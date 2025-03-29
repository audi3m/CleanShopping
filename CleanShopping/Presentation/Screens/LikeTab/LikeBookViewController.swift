//
//  LikeBookViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import UIKit
import SnapKit

final class LikeBookViewController: BaseViewController {
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.register(BookCoverCollectionViewCell.self, forCellWithReuseIdentifier: BookCoverCollectionViewCell.id)
    collectionView.keyboardDismissMode = .onDrag
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  // 좋아요한 도서 목록
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func setHierarchy() {
    
  }
  
  override func setLayout() {
    
  }
  
  override func setUI() {
    navigationItem.title = "좋아요"
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
        return self.createFilterSectionLayout()
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
}
