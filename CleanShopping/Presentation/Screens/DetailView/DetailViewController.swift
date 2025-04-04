//
//  DetailViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/13/25.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

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
  private let infoStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 5
    view.alignment = .fill
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    view.isLayoutMarginsRelativeArrangement = true
    return view
  }()
  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.backgroundColor = .white
    return view
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.numberOfLines = 2
    return label
  }()
  private let authorLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 17, weight: .regular)
    return label
  }()
  private let publishLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .light)
    label.textColor = .secondaryLabel
    return label
  }()
  private let priceLabel: UILabel = {
    let label = UILabel()
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
  
  private let disposeBag = DisposeBag()
  private let viewModel: DetailViewViewModel
  private var isFavorite = false
  
  init(viewModel: DetailViewViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    
    infoStackView.addArrangedSubview(titleLabel)
    infoStackView.addArrangedSubview(authorLabel)
    infoStackView.addArrangedSubview(publishLabel)
    infoStackView.addArrangedSubview(priceLabel)
    
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(infoStackView)
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
    navigationItem.title = "상세 정보"
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
    authorLabel.text = book.author
    publishLabel.text = book.publish
    priceLabel.text = book.price
    descLabel.text = book.description
  }
}
