//
//  SearchBookViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class SearchBookViewModel {
  private let disposeBag = DisposeBag()
  private let networkManager: BookNetworkManager
  
  var input = Input()
  var output = Output()
  
  private let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfSearchBook> { (datasource, collectionView, indexPath, item) in
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnterHobbyCollectionViewCell.reuseIdentifier, for: indexPath) as? EnterHobbyCollectionViewCell else { return UICollectionViewCell() }
          
          cell.button.setTitle("메뉴: \\(item)", for: .normal)
          cell.backgroundColor = .brandGreen
          
          return cell
      }
  
  
  var dataSource
  var searchPage = BehaviorRelay<Int>(value: 1)
  var isLastPage = BehaviorRelay<Bool>(value: false)
  
  init(networkManager: BookNetworkManager) {
    self.networkManager = networkManager
    transform()
  }
  
}

extension SearchBookViewModel {
  func transform() {
    Observable.combineLatest(input.api, input.sortOption)
      .map { _ in }
      .bind(to: output.optionChanged)
      .disposed(by: disposeBag)
  }
}

extension SearchBookViewModel {
  struct Input {
    var searchButtonClicked = PublishRelay<Void>()
    var api = BehaviorRelay<BookAPI>(value: .naver)
    var query = PublishRelay<String>()
    var sortOption = BehaviorRelay<SortOption>(value: .accuracy)
    
    var tappedBook = PublishRelay<Book>()
  }
  
  struct Output {
    var tappedBook = PublishRelay<Book>()
    var optionChanged = PublishRelay<Void>()
  }
  
}

// Search
extension SearchBookViewModel {
  
  func getSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
    let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
    let bookResponse = try await SearchBookRepository.shared.newSearchBook(bookRequest: bookRequest)
    return bookResponse
  }
  
  func resetProperties() {
    input.query = PublishRelay<String>()
    searchPage.accept(1)
  }
  
  
  
}





// Save
extension SearchBookViewModel {
  func saveBook() {
    
  }
}
