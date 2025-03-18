//
//  DetailViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/13/25.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: BaseViewController {
  
  private let imageView: UIImageView = {
    let view = UIImageView()
    return view
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  private let priceLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  private let descLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private let viewModel = DetailViewViewModel()
  
//  let book = Book(title: <#T##String#>, link: <#T##String#>, image: <#T##String#>,
//                  author: <#T##String#>, discount: <#T##String?#>, publisher: <#T##String#>,
//                  pubdate: <#T##String#>, isbn: <#T##String#>, description: <#T##String#>)
  
  // 표지
  // 제목
  // 가격
  // 내용
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBind()
    makeNavigationItems()
  }
  
  override func setHierarchy() {
    
  }
  
  override func setLayout() {
    
  }
  
  override func setUI() {
    
  }
  
}

// Rx
extension DetailViewController {
  private func rxBind() {
    
  }
}

extension DetailViewController {
  
  private func makeNavigationItems() {
    let item = UIBarButtonItem(image: UIImage(systemName: "heart"),
                               style: .plain, target: self,
                               action: #selector(dummyFunction))
    
    navigationItem.leftBarButtonItems = [item]
  }
  
  @objc private func dummyFunction() {
    
  }
  
}
