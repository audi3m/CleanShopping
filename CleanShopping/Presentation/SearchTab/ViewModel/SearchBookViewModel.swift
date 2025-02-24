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
  private let searchBookRepository: SearchBookRepository
  
  var input = Input()
  var output = Output()
  
  var searchPage = BehaviorRelay<Int>(value: 1)
  var isLastPage = BehaviorRelay<Bool>(value: false)
  
  init(searchBookRepository: SearchBookRepository) {
    self.searchBookRepository = SearchBookRepository.shared
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
    var api = BehaviorRelay<BookAPI>(value: .naver)
    var query = PublishRelay<String>()
    var sortOption = BehaviorRelay<SortOption>(value: .accuracy)
    var searchButtonClicked = PublishRelay<Void>()
    var tappedBook = PublishRelay<Book>()
  }
  
  struct Output {
    var searchBookSectionModel = BehaviorRelay<[SearchBookSectionModel2]>(value: [])
    var tappedBook = PublishRelay<Book>()
    var optionChanged = PublishRelay<Void>()
  }
  
}

// Search
extension SearchBookViewModel {
  
  func fetchSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) {
    let request = BookRequest(api: api, query: query, page: page, sort: sort)
    
    searchBookRepository.searchBookSingle(bookRequest: request)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] result in
        guard let self else { return }
        switch result {
        case .success(let response):
          let books = response.books.map { SearchBookSectionItem2.bodyItem(book: $0) }
          let headerSection = SearchBookSectionModel2.headerSection(items: [.headerItem(api: api)])
          
          var updatedSections = self.output.searchBookSectionModel.value
          
          if let bodyIndex = updatedSections.firstIndex(where: {
            if case .bodySection = $0 { return true }
            return false
          }) {
            if page == 1 {
              updatedSections[bodyIndex] = .bodySection(items: books)
            } else {
              if case .bodySection(let existingItems) = updatedSections[bodyIndex] {
                updatedSections[bodyIndex] = .bodySection(items: existingItems + books)
              }
            }
          } else {
            updatedSections.append(.bodySection(items: books))
          }
          
          if updatedSections.first(where: {
            if case .headerSection = $0 { return true }
            return false
          }) == nil {
            updatedSections.insert(headerSection, at: 0)
          }
          
          self.output.searchBookSectionModel.accept(updatedSections)
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      }, onFailure: { error in
        print(error.localizedDescription)
      })
      .disposed(by: disposeBag)
  }
  
  func getSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
    let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
    let bookResponse = try await searchBookRepository.newSearchBook(bookRequest: bookRequest)
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
