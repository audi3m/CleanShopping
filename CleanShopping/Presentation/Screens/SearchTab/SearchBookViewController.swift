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
    return searchBar
  }()
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.register(BookApiSelectionCollectionViewCell.self, forCellWithReuseIdentifier: BookApiSelectionCollectionViewCell.id)
    collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
    collectionView.keyboardDismissMode = .onDrag
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  private let disposeBag = DisposeBag()
  private let viewModel: SearchBookViewModel
  
  init(viewModel: SearchBookViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBind()
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

// Navigation
extension SearchBookViewController {
  
  private func setupNavigationBarMenu() {
    let apiItems = BookAPI.allCases.map { apiType in
      UIAction(title: apiType.rawValue, state: viewModel.input.searchAPI.value == apiType ? .on : .off) { [weak self] _ in
        guard let self else { return }
        self.viewModel.input.searchAPI.accept(apiType)
        print(apiType.rawValue)
      }
    }
    
    let sortItems = SortOption.allCases.map { sortType in
      UIAction(title: sortType.stringValue, state: viewModel.input.searchSort.value == sortType ? .on : .off) { [weak self] _ in
        guard let self else { return }
        self.viewModel.input.searchSort.accept(sortType)
        print(sortType.rawValue)
      }
    }
    
    let apiMenu = UIMenu(title: "사이트", options: .displayInline, children: apiItems)
    let sortMenu = UIMenu(title: "순서", options: .displayInline, children: sortItems)
    
    let menu = UIMenu(title: "", children: [apiMenu, sortMenu])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "필터", menu: menu)
  }
  
}
