//
//  BookApiSelectionCollectionViewCell.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import UIKit

final class BookApiSelectionCollectionViewCell: UICollectionViewCell {
    static let id = "BookApiSelectionCollectionViewCell"
    
    private let apiLabel: UILabel = {
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

extension BookApiSelectionCollectionViewCell {
    private func configureHierarchy() {
        let views = [apiLabel]
        views.forEach { contentView.addSubview($0) }
    }
    
    private func configureUI() {
        apiLabel.snp.makeConstraints { make in
            
        }
    }
    
    func configureData(api: BookAPI) {
        apiLabel.text = api.rawValue
    }
}
