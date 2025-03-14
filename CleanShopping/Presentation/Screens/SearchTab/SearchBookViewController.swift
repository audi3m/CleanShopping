//
//  SearchBookViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class SearchBookViewController: BaseViewController {
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.backgroundImage = UIImage()
    searchBar.placeholder = "검색해보세요..."
    searchBar.delegate = self
    return searchBar
  }()
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.register(BookApiSelectionCollectionViewCell.self, forCellWithReuseIdentifier: BookApiSelectionCollectionViewCell.id)
    collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
    collectionView.delegate = self
    collectionView.prefetchDataSource = self
    collectionView.keyboardDismissMode = .onDrag
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  //  private var dataSource: UICollectionViewDiffableDataSource<SearchBookSection, SearchBookSectionItem>!
  
  //  private let dataSource2 = RxCollectionViewSectionedReloadDataSource<SearchBookSectionModel2> { dataSource, collectionView, indexPath, sectionType in
  //    switch sectionType {
  //    case .headerItem(let api):
  //      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookApiSelectionCollectionViewCell.id, for: indexPath) as? BookApiSelectionCollectionViewCell else {
  //        return UICollectionViewCell()
  //      }
  //      cell.configureData(api: api)
  //      return cell
  //    case .bodyItem(let book):
  //      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as? BookCollectionViewCell else {
  //        return UICollectionViewCell()
  //      }
  //      cell.configureData(book: book)
  //      return cell
  //    }
  //  }
  
  private let disposeBag = DisposeBag()
  private let viewModel: SearchBookViewModel2
  
  init(viewModel: SearchBookViewModel2) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBind()
    //    configureDataSource()
    //    initialSnapshot()
//    setupNavigationBarMenu()
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
extension SearchBookViewController {
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
      .bind(to: viewModel.input.loadMore)
      .disposed(by: disposeBag)
    
    let dataSource = makeRxDataSource()
    
    viewModel.output.dataSource
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    viewModel.output.optionChanged
      .bind(with: self) { owner, _ in
        owner.setupNavigationBarMenu()
      }
      .disposed(by: disposeBag)
    
  }
}

// RxDataSource
extension SearchBookViewController {
  private func makeRxDataSource() -> RxCollectionViewSectionedAnimatedDataSource<SearchBookSectionModel2> {
    return RxCollectionViewSectionedAnimatedDataSource<SearchBookSectionModel2> { dataSource, collectionView, indexPath, sectionType in
      switch sectionType {
      case .headerItem(let api):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookApiSelectionCollectionViewCell.id, for: indexPath) as? BookApiSelectionCollectionViewCell else {
          return UICollectionViewCell()
        }
        cell.configureData(api: api)
        return cell
      case .bodyItem(let book):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as? BookCollectionViewCell else {
          return UICollectionViewCell()
        }
        cell.configureData(book: book)
        return cell
      }
    }
  }
}

// Search Bar
extension SearchBookViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    resetProperties()

//    Task {
//      do {
//        let bookResponse = try await getSearchResults(api: api, query: query, page: page, sort: sort)
//        appendItems(newItems: bookResponse.books)
//      } catch {
//        print("Error fetching next page: \(error)")
//      }
//    }
  }

}

// CollectionView Delegate
extension SearchBookViewController: UICollectionViewDelegate {
  
}

// CollectionView Prefetch
extension SearchBookViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    
  }
  
//  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//    guard !isEndPage else { return }
//
//    let currentItemCount = dataSource.snapshot().itemIdentifiers.count
//    for indexPath in indexPaths {
//      if indexPath.item == currentItemCount - 3 {
//        page += 1
//        Task {
//          do {
//            let bookResponse = try await getSearchResults(api: api, query: query, page: page, sort: sort)
//            handleValidResponse(response: bookResponse)
//          } catch {
//            page -= 1
//            print("Error fetching next page: \(error)")
//          }
//        }
//      }
//    }
//  }

}

// Network Request
extension SearchBookViewController {
  
//  private func handleValidResponse(response: BookResponse) {
//    isEndPage = response.isEnd
//    appendItems(newItems: response.books)
//  }
  
}

// Compositional Layout & Sections
extension SearchBookViewController {
  
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
//extension SearchBookViewController {
//  private func configureDataSource() {
//    dataSource = UICollectionViewDiffableDataSource<SearchBookSection, SearchBookSectionItem>(collectionView: collectionView) { collectionView, indexPath, item in
//      switch item {
//      case .filterOption(let api):
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookApiSelectionCollectionViewCell.id, for: indexPath) as! BookApiSelectionCollectionViewCell
//        cell.configureData(api: api)
//        return cell
//      case .listData(let book):
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
//        cell.configureData(book: book)
//        return cell
//      }
//    }
//  }
//
//  private func initialSnapshot() {
//    var snapshot = NSDiffableDataSourceSnapshot<SearchBookSection, SearchBookSectionItem>()
//    snapshot.appendSections([.filter, .list])
//
//    let filterItems = BookAPI.allCases.map { SearchBookSectionItem.filterOption($0) }
//    snapshot.appendItems(filterItems, toSection: .filter)
//
//    let listItems = [SearchBookSectionItem]()
//    snapshot.appendItems(listItems, toSection: .list)
//
//    dataSource.apply(snapshot, animatingDifferences: true)
//  }
//
//  private func appendItems(newItems: [Book]) {
//    var snapshot = dataSource.snapshot()
//    let items = newItems.map { SearchBookSectionItem.listData($0) }
//    snapshot.appendItems(items, toSection: .list)
//    dataSource.apply(snapshot, animatingDifferences: true)
//  }
//
//  private func clearAllItems() {
//    var snapshot = dataSource.snapshot()
//    snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .list))
//    dataSource.apply(snapshot, animatingDifferences: true)
//  }
//
//}

// Test
extension SearchBookViewController {
  
  private func setupNavigationBarMenu() {
    let apiItems = BookAPI.allCases.map { apiType in
      UIAction(title: apiType.rawValue, state: viewModel.input.searchAPI.value == apiType ? .on : .off) { [weak self] _ in
        guard let self else { return }
        self.viewModel.input.searchAPI.accept(apiType)
      }
    }
    
    let sortItems = SortOption.allCases.map { sortType in
      UIAction(title: sortType.stringValue, state: viewModel.input.searchSort.value == sortType ? .on : .off) { [weak self] _ in
        guard let self else { return }
        self.viewModel.input.searchSort.accept(sortType)
      }
    }
    
    let apiMenu = UIMenu(title: "사이트", options: .displayInline, children: apiItems)
    let sortMenu = UIMenu(title: "순서", options: .displayInline, children: sortItems)
    
    let menu = UIMenu(title: "", children: [apiMenu, sortMenu])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "필터", menu: menu)
  }
  
}
