//
//  SearchViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    // 검색창, 검색 결과 리스트, 상세화면
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension SearchViewController {
    
    private func configureConstraints() {
        
    }
    
    private func configureUI() {
        
    }
    
    
}
