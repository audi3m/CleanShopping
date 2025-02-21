//
//  BookApiSelectionCollectionViewCell.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import UIKit
import SnapKit

final class BookApiSelectionCollectionViewCell: UICollectionViewCell {
  static let id = "BookApiSelectionCollectionViewCell"
  
  private let roundedBackground: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    view.layer.cornerRadius = 8
    return view
  }()
  private let apiLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureHierarchy()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BookApiSelectionCollectionViewCell {
  private func configureHierarchy() {
    contentView.addSubview(roundedBackground)
    roundedBackground.addSubview(apiLabel)
  }
  
  private func configureUI() {
    roundedBackground.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    apiLabel.snp.makeConstraints { make in
      make.verticalEdges.equalToSuperview().inset(8)
      make.horizontalEdges.equalToSuperview().inset(12)
    }
  }
  
  func configureData(api: BookAPI) {
    apiLabel.text = api.rawValue
  }
}
