//
//  LikeBookViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class LikeBookViewController: BaseViewController {
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.id)
    collectionView.keyboardDismissMode = .onDrag
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  private let disposeBag = DisposeBag()
  private let viewModel: LikeBookViewModel
  
  init(viewModel: LikeBookViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBind()
  }
  
  override func setHierarchy() {
    view.addSubview(collectionView)
  }
  
  override func setLayout() {
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func setUI() {
    navigationItem.title = "좋아요"
  }
  
}

// Rx
extension LikeBookViewController {
  private func rxBind() {
    
    
    
    let dataSource = makeRxDataSource()
    
    viewModel.output.dataSource
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}

// RxDataSource
extension LikeBookViewController {
  private func makeRxDataSource() -> RxCollectionViewSectionedAnimatedDataSource<LikeBookSectionModel2> {
    return RxCollectionViewSectionedAnimatedDataSource<LikeBookSectionModel2> { dataSource, collectionView, indexPath, sectionType in
      switch sectionType {
      case .bodyItem(let book):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCoverCollectionViewCell.id, for: indexPath) as? BookCoverCollectionViewCell else {
          return UICollectionViewCell()
        }
        cell.configureData(book: book)
        return cell
      }
    }
  }
}

// CollectionView
extension LikeBookViewController {
  private func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
      guard let self else { return nil }
      let section = LikeBookSection.allCases[sectionIndex]
      switch section {
      case .body:
        return self.bodySectionLayout()
      }
    }
  }
  
  private func bodySectionLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1/3),
      heightDimension: .absolute(100)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .none
    section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
    section.interGroupSpacing = 10
    
    return section
  }
}
