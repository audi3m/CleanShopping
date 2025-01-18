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
        configureLayout()
        configureUI()
        
//        let params = KakaoBookRequestParameters(query: "일론", page: 1)
//        BookNetworkService.shared.searhKakaoBooks(params: params) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        let params2 = NaverBookRequestParameters(query: "일론", start: 1)
        BookNetworkService.shared.searhNaverBooks(params: params2) { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure): 
                print(failure)
            }
        }
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController {
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "도서 검색"
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
