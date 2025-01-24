//
//  SearchViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchBookSection, BookSectionItem>! = nil
    
    // 검색창, 검색 결과 리스트, 상세화면
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "검색해보세요..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        return collectionView
    }()
    
    var query = ""
    var page = 1
    var isEnd = false
    var bookList = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func setUI() {
        view.backgroundColor = .white
        navigationItem.title = "도서 검색"
    }

}

// Search Bar
extension SearchViewController: UISearchBarDelegate {
    // query 입력
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        isEnd = false
        naverSearchTest(api: .naver, query: query, page: page)
    }
}

// CollectionView Delegate & DataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
        let book = bookList[indexPath.row]
        cell.configureData(book: book)
        return cell
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = SearchBookSection.allCases[sectionIndex]
            
            switch section {
            case .searchResultSection:
                return self.todoSection(layoutEnvironment: layoutEnvironment)
            }
        }
    }
    
    private func configureDataSource() {
        let bookSearchResultRegistration = UICollectionView.CellRegistration<BookCollectionViewCell, BookSectionItem> { (cell, indexPath, item) in
            if case let .searchResult(book) = item {
                cell.configureData(book: book)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<SearchBookSection, BookSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BookSectionItem) -> UICollectionViewCell? in
            switch identifier {
            case .searchResult:
                return collectionView.dequeueConfiguredReusableCell(using: bookSearchResultRegistration, for: indexPath, item: identifier)
            }
            
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SearchBookSection, BookSectionItem>()
        snapshot.appendSections(SearchBookSection.allCases)
        let bookSearchResult = [Book]().map { BookSectionItem.searchResult($0) }
        snapshot.appendItems(bookSearchResult, toSection: .searchResultSection)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

// CollectionView Prefetch
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == bookList.count - 2 && !isEnd {
                page += 1
                naverSearchTest(api: .naver ,query: query, page: page)
            }
        }
    }
    
}

// Network Request
extension SearchViewController {
    
    private func applyResponse(response: BookResponse) {
        self.isEnd = response.isEnd
        
        
    }
    
    private func applyBookList(books: [Book]) {
        if page == 1 {
            self.bookList = books
        } else {
            bookList.append(contentsOf: books)
        }
    }
    
    private func kakaoSearchTest(query: String, page: Int) {
        let params = KakaoBookRequestParameters(query: query, sort: .accuracy, page: page)
        BookNetworkService.shared.searhKakaoBooks(params: params) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                let response = success.toDomain()
                self.applyResponse(response: response)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func naverSearchTest(api: BookAPI, query: String, page: Int) {
        let params2 = BookRequest(api: api,
                                  query: query,
                                  page: page).toDTO() as! NaverBookRequestParameters
//        let params = NaverBookRequestParameters(query: query, start: page, sort: .sim)
        BookNetworkService.shared.searhNaverBooks(params: params2) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let success):
                let bookResponse = success.toDomain()
                self.bookList.append(contentsOf: bookResponse.books)
            case .failure(let failure):
                print(failure)
                self.bookList = []
            }
        }
    }
            
}

// Layout
extension SearchViewController {
    static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    private func todoSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
