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
  
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  
  private let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 5
    view.alignment = .fill
    view.backgroundColor = .systemGray6
    return view
  }()
  
  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.backgroundColor = .white
    return view
  }()
  private let titleLabel: PaddedLabel = {
    let label = PaddedLabel()
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.numberOfLines = 2
    label.backgroundColor = .white
    return label
  }()
  private let priceLabel: PaddedLabel = {
    let label = PaddedLabel()
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    label.textAlignment = .right
    label.backgroundColor = .white
    return label
  }()
  private let descLabel: PaddedLabel = {
    let label = PaddedLabel()
    label.numberOfLines = 0
    label.backgroundColor = .white
    return label
  }()
  private let spacerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private let viewModel = DetailViewViewModel()
  
  private var isFavorite: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBind()
    makeNavigationItems()
    setWithSampleBook()
  }
  
  override func setHierarchy() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(stackView)
    
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(priceLabel)
    stackView.addArrangedSubview(descLabel)
    stackView.addArrangedSubview(spacerView)
  }
  
  override func setLayout() {
    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    contentView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView.contentLayoutGuide)
      make.width.equalTo(scrollView.frameLayoutGuide)
    }
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    imageView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(250)
    }
    spacerView.snp.makeConstraints { make in
      make.height.equalTo(50)
    }
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
    item.tintColor = .label
    navigationItem.rightBarButtonItems = [item]
  }
  
  @objc private func dummyFunction() {
    isFavorite.toggle()
    let imageName = isFavorite ? "heart.fill" : "heart"
    navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    navigationItem.rightBarButtonItem?.tintColor = isFavorite ? .systemPink : .label
  }
  
}

// Sample Book
extension DetailViewController {
  private func setWithSampleBook() {
    let book = Book.sample
    let url = URL(string: book.image)
    imageView.kf.setImage(with: url)
    titleLabel.text = book.title
    priceLabel.text = book.price
    descLabel.text = book.description
  }
}
