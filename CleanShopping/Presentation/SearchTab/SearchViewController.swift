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
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchBookSection, BookSectionItem>! = nil
    
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
    
    var api = BookAPI.naver
    var query = ""
    var page = 1
    var isEnd = false
    var bookList = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
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
        navigationItem.title = "도서 검색"
    }

}

// Search Bar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        query = searchBar.text ?? ""
        page = 1
        isEnd = false
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
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            let section = SearchBookSection.allCases[sectionIndex]
            switch section {
            case .searchResultSection:
                return self.searchBookResultSection(layoutEnvironment: layoutEnvironment)
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
    
    private func appendBooks(books: [Book]) {
        var currentSnapshot = dataSource.snapshot()
        let items = books.map { BookSectionItem.searchResult($0) }
        currentSnapshot.appendItems(items, toSection: .searchResultSection)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}

// CollectionView Prefetch
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == bookList.count - 2 && !isEnd {
                
                
            }
        }
    }
    
}

// Network Request
extension SearchViewController {
    
    
    
    
            
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
    
    private func searchBookResultSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
