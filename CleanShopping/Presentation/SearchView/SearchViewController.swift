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
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "검색해보세요..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchViewController.layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureUI()
    }

}

extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController {
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func configureUI() {
        searchBar.snp.makeConstraints { make in
            
        }
        
        collectionView.snp.makeConstraints { make in
            
        }
    }
    
    
}

extension SearchViewController {
    static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }()
}
