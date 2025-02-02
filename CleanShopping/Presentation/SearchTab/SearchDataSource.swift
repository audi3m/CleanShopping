//
//  SearchDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 2/2/25.
//

import Foundation

//private func configureDataSource() {
//    let bookSearchResultRegistration = UICollectionView.CellRegistration<BookCollectionViewCell, BookSectionItem> { (cell, indexPath, item) in
//        if case let .searchResult(book) = item {
//            cell.configureData(book: book)
//        }
//    }
//    
//    dataSource = UICollectionViewDiffableDataSource<SearchBookSection, BookSectionItem>(collectionView: collectionView) {
//        (collectionView: UICollectionView, indexPath: IndexPath, identifier: BookSectionItem) -> UICollectionViewCell? in
//        switch identifier {
//        case .searchResult:
//            return collectionView.dequeueConfiguredReusableCell(using: bookSearchResultRegistration, for: indexPath, item: identifier)
//        }
//    }
//    
//    var snapshot = NSDiffableDataSourceSnapshot<SearchBookSection, BookSectionItem>()
//    snapshot.appendSections(SearchBookSection.allCases)
//    let bookSearchResult = [Book]().map { BookSectionItem.searchResult($0) }
//    snapshot.appendItems(bookSearchResult, toSection: .searchResultSection)
//    
//    dataSource.apply(snapshot, animatingDifferences: false)
//}
//
//private func appendBooks(books: [Book]) {
//    var currentSnapshot = dataSource.snapshot()
//    let items = books.map { BookSectionItem.searchResult($0) }
//    currentSnapshot.appendItems(items, toSection: .searchResultSection)
//    dataSource.apply(currentSnapshot, animatingDifferences: true)
//}
