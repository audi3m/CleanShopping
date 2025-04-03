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
    view.contentMode = .scaleAspectFit
    return view
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13, weight: .semibold)
    return label
  }()
  private let authorLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .secondaryLabel
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureHierarchy()
    configureLayout()
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
    contentView.addSubview(authorLabel)
  }
  
  private func configureLayout() {
    imageView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
      make.height.equalTo(imageView.snp.width).multipliedBy(1.45)
    }
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(5)
      make.horizontalEdges.equalToSuperview().inset(7)
    }
    authorLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(2.5)
      make.horizontalEdges.equalToSuperview().inset(7)
    }
  }
  
  private func configureUI() {
    contentView.backgroundColor = .systemGray6
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true
  }
  
  func configureData(book: Book) {
    let coverUrl = URL(string: book.image)
    imageView.kf.setImage(with: coverUrl)
    titleLabel.text = book.title
    authorLabel.text = book.author
  }
  
}
