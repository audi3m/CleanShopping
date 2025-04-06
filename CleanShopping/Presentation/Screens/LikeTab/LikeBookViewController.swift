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
    
    collectionView.rx
      .modelSelected(Book.self)
      .bind(with: self) { owner, book in
        owner.viewModel.action(.bookTapped(book))
        if let indexPath = owner.collectionView.indexPathsForSelectedItems?.first {
          self.collectionView.deselectItem(at: indexPath, animated: true)
        }
      }
      .disposed(by: disposeBag)
    
    let dataSource = makeRxDataSource()
    
    viewModel.output.dataSource
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    viewModel.output.tappedBook
      .bind(with: self) { owner, book in
        let detailView = DetailViewController(viewModel: .init(saveUseCase: owner.viewModel.saveBookUseCase, book: book))
        owner.present(detailView, animated: true)
      }
      .disposed(by: disposeBag)
  }
}

// RxDataSource
extension LikeBookViewController {
  private func makeRxDataSource() -> RxCollectionViewSectionedAnimatedDataSource<LikeBookSectionModel> {
    return RxCollectionViewSectionedAnimatedDataSource<LikeBookSectionModel> { dataSource, collectionView, indexPath, sectionType in
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
    let itemInset: CGFloat = 2.5
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: itemInset*2, leading: itemInset, bottom: itemInset*2, trailing: itemInset)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
    
    return section
  }
  
}
