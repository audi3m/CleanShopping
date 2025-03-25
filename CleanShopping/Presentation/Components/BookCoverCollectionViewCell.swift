//
//  BookCoverCollectionViewCell.swift
//  CleanShopping
//
//  Created by J Oh on 3/25/25.
//

import UIKit
import Kingfisher
import SnapKit

final class BookCoverCollectionViewCell: UICollectionViewCell {
  static let id = "BookCoverCollectionViewCell"
  
  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 8
    return view
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 11, weight: .semibold)
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

extension BookCoverCollectionViewCell {
  private func configureHierarchy() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
  }
  
  private func configureUI() {
    imageView.snp.makeConstraints { make in
      
    }
    titleLabel.snp.makeConstraints { make in
      
    }
  }
  
  func configureData(book: Book) {
    let coverUrl = URL(string: book.image)
    imageView.kf.setImage(with: coverUrl)
  }
}
