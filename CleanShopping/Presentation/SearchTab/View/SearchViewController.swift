//
//  SearchViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "검색해보세요..."
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        collectionView.register(BookApiSelectionCollectionViewCell.self, forCellWithReuseIdentifier: "BookApiSelectionCollectionViewCell")
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchBookSection, SearchBookSectionItem>!
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchBookViewModel(networkManager: BookNetworkManager.shared)
    private let searchBookRepository = SearchBookRepository.shared
    
    var api = BookAPI.naver
    var query = ""
    var page = 1
    var sort = SortOption.accuracy
    
    var isEndPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxBind()
        configureDataSource()
        initialSnapshot()
        setupNavigationBarMenu()
    }
    
    override func setHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        navigationItem.title = "도서 검색"
    }
    
}

// Rx
extension SearchViewController {
    private func rxBind() {
        searchBar.rx.searchButtonClicked
            .bind(to: viewModel.input.searchButtonClicked)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.input.searchQuery)
            .disposed(by: disposeBag)
        
        collectionView.rx
            .didScroll
            .withLatestFrom(collectionView.rx.contentOffset)
            .filter { [weak self] offset in
                guard let self else { return false }
                let position = offset.y + self.collectionView.frame.size.height
                return position >= self.collectionView.contentSize.height
            }
            .map { _ in }
            .bind(to: viewModel.input.loadNextPage)
            .disposed(by: disposeBag)
        
        var searchAPI = PublishRelay<BookAPI>()
        var searchPage = PublishRelay<Int>()
        var searchSortOption = PublishRelay<SortOption>()
        var tappedBook = PublishRelay<Book>()
    }
}

// Search Bar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetProperties()
        query = searchBar.text ?? ""
        
        Task {
            do {
                let bookResponse = try await getSearchResults(api: api, query: query, page: page, sort: sort)
                appendItems(newItems: bookResponse.books)
            } catch {
                print("Error fetching next page: \(error)")
            }
        }
    }
    
}

// CollectionView Delegate
extension SearchViewController: UICollectionViewDelegate {
    
    
}

// CollectionView Prefetch
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard !isEndPage else { return }
        
        let currentItemCount = dataSource.snapshot().itemIdentifiers.count
        for indexPath in indexPaths {
            if indexPath.item == currentItemCount - 3 {
                page += 1
                Task {
                    do {
                        let bookResponse = try await getSearchResults(api: api, query: query, page: page, sort: sort)
                        handleValidResponse(response: bookResponse)
                    } catch {
                        page -= 1
                        print("Error fetching next page: \(error)")
                    }
                }
            }
        }
    }
    
}

// Network Request
extension SearchViewController {
    
    private func handleValidResponse(response: BookResponse) {
        isEndPage = response.isEnd
        appendItems(newItems: response.books)
    }
    
    private func getSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
        guard !query.isEmpty else { return BookResponse(totalCount: 0, books: [], isEnd: true) }
        let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
        let bookResponse = try await searchBookRepository.newSearchBook(bookRequest: bookRequest)
        return bookResponse
    }
    
    private func resetProperties() {
        clearAllItems()
        query = ""
        page = 1
        isEndPage = false
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

// Compositional Layout & Sections
extension SearchViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self else { return nil }
            let section = SearchBookSection.allCases[sectionIndex]
            switch section {
            case .filter:
                return self.createFilterSectionLayout()
            case .list:
                return self.createListSectionLayout(layoutEnvironment: layoutEnvironment)
            }
        }
    }
    
    private func createFilterSectionLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 10
        
        return section
    }
    
    private func createListSectionLayout(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
}

// DataSource
extension SearchViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SearchBookSection, SearchBookSectionItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .filterOption(let api):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookApiSelectionCollectionViewCell.id, for: indexPath) as! BookApiSelectionCollectionViewCell
                cell.configureData(api: api)
                return cell
            case .listData(let book):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
                cell.configureData(book: book)
                return cell
            }
        }
    }
    
    private func initialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SearchBookSection, SearchBookSectionItem>()
        snapshot.appendSections([.filter, .list])
        
        let filterItems = BookAPI.allCases.map { SearchBookSectionItem.filterOption($0) }
        snapshot.appendItems(filterItems, toSection: .filter)
        
        let listItems = [SearchBookSectionItem]()
        snapshot.appendItems(listItems, toSection: .list)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func appendItems(newItems: [Book]) {
        var snapshot = dataSource.snapshot()
        let items = newItems.map { SearchBookSectionItem.listData($0) }
        snapshot.appendItems(items, toSection: .list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func clearAllItems() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .list))
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

// Test
extension SearchViewController {
    
    private func setNavItems() {
        let item = UIBarButtonItem(image: UIImage(systemName: "star"),
                                   style: .plain, target: self,
                                   action: #selector(printValues))
        
        navigationItem.leftBarButtonItems = [item]
    }

    @objc private func printValues() {
        print("------------------------------------")
        print("Query: \(searchBar.text ?? "")\nPage: \(page)\nIsEnd: \(isEndPage)")
        print("------------------------------------")
    }
    
    private func setupNavigationBarMenu() {
        let apiItems = BookAPI.allCases.map { apiType in
            UIAction(title: apiType.rawValue, state: self.api == apiType ? .on : .off) { _ in
                self.api = apiType
                self.setupNavigationBarMenu()
            }
        }
        
        let menu = UIMenu(title: "", children: apiItems)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: api.rawValue, menu: menu)
    }
}
