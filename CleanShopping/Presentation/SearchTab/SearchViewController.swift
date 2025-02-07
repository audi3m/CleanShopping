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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout2())
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        collectionView.register(BookApiSelectionCollectionViewCell.self, forCellWithReuseIdentifier: "BookApiSelectionCollectionViewCell")
        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchBookSection, SearchBookSectionItem>!
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchBookViewModel(networkManager: BookNetworkManager.shared)
    private let searchBookRepository = SearchBookRepository.shared
    
    var api = BookAPI.kakao
    var query = ""
    var page = 1
    var sort = SortOption.accuracy
    
    var isEndPage = false
    var searchBookResult = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxBind()
        configureDataSource()
        initialSnapshot()
        
        Task {
            do {
                let bookResponse = try await getSearchResults(api: .kakao, query: "일론", page: 1, sort: .accuracy)
                isEndPage = bookResponse.isEnd
                searchBookResult.append(contentsOf: bookResponse.books)
                dump(searchBookResult)
            } catch {
                print("Error fetching next page: \(error)")
            }
        }
        
    }
    
    override func setHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
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
        
    }
}

// Rx
extension SearchViewController {
    private func reBind() {
        
    }
}

// Network
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetProperties()
        
        Task {
            do {
                let bookResponse = try await getSearchResults(api: api, query: searchBar.text!, page: page, sort: sort)
                isEndPage = bookResponse.isEnd
                searchBookResult.append(contentsOf: bookResponse.books)
                collectionView.reloadData()
                dump(searchBookResult)
            } catch {
                print("Error fetching next page: \(error)")
            }
        }
    }
    
}

// CollectionView Delegate & DataSource
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchBookResult.count
    }
    
}

//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
//        let book = searchBookResult[indexPath.row]
//        cell.configureData(book: book)
//        return cell
//    }
//}

// CollectionView Prefetch
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == searchBookResult.count - 2 && !isEndPage {
                print("prefetch page \(page)")
                page += 1
                Task {
                    do {
                        let bookResponse = try await getSearchResults(api: api, query: query, page: page, sort: sort)
                        isEndPage = bookResponse.isEnd
                        searchBookResult.append(contentsOf: bookResponse.books)
                        print("------ # of Books: \(searchBookResult.count) ------")
                        //                        collectionView.reloadData()
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
    
    func getSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
        let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
        let bookResponse = try await searchBookRepository.newSearchBook(bookRequest: bookRequest)
        isEndPage = bookResponse.isEnd
        return bookResponse
    }
    
    private func resetProperties() {
        query = ""
        page = 1
        isEndPage = false
        searchBookResult = []
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

// Layout 1
extension SearchViewController {
    
    private func searchBookResultSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
}

// Compositional Layout 2
extension SearchViewController {
    
    private func createLayout2() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = SearchBookSection.allCases[sectionIndex]
            switch section {
            case .filter:
                return self.createFilterSectionLayout()
            case .list:
                return self.createListSectionLayout()
            }
        }
    }
    
    private func createFilterSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
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
        
        let items = searchBookResult.map { SearchBookSectionItem.listData($0) }
        snapshot.appendItems(items, toSection: .list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func addItems(newItems: [Book]) {
        var snapshot = dataSource.snapshot()
        searchBookResult.append(contentsOf: newItems)
        let items = newItems.map { SearchBookSectionItem.listData($0) }
        snapshot.appendItems(items, toSection: .list)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func clearAllItems() {
        var snapshot = NSDiffableDataSourceSnapshot<SearchBookSection, SearchBookSectionItem>()
        snapshot.appendSections([.filter, .list])
//        snapshot.appendItems(filterItems, toSection: .filter)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
