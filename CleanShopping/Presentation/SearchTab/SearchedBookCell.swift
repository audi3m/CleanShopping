//
//  SearchedBookCell.swift
//  CleanShopping
//
//  Created by J Oh on 1/13/25.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchedBookCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
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

extension SearchedBookCell {
    private func configureHierarchy() {
        let views = [imageView, titleLabel, infoLabel, priceLabel]
        views.forEach { contentView.addSubview($0) }
    }
    
    private func configureUI() {
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            // 너비
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(10)
            make.leading.equalTo(imageView).offset(20)
            make.trailing.equalToSuperview().inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
            
    }
    
    func configureData(book: Book) {
        imageView.kf.setImage(with: URL(string: book.image))
        titleLabel.text = book.title
        infoLabel.text = book.info
        priceLabel.text = book.price
    }
}
