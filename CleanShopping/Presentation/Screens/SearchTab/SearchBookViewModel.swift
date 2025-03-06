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
  
  private let searchBookUseCase: SearchBookUseCase
  private let saveBookUseCase: SaveBookUseCase
  
  var input = Input()
  var output = Output()
  
  var searchPage = BehaviorRelay<Int>(value: 1)
  var isLastPage = BehaviorRelay<Bool>(value: false)
  
  init(searchBookUseCase: SearchBookUseCase,
       saveBookUseCase: SaveBookUseCase) {
    
    self.searchBookUseCase = searchBookUseCase
    self.saveBookUseCase = saveBookUseCase
    
    setupInitialSections()
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
    var dataSource = BehaviorRelay<[SearchBookSectionModel2]>(value: [])
    var tappedBook = PublishRelay<Book>()
    var optionChanged = PublishRelay<Void>()
  }
  
}

// UseCase Search
extension SearchBookViewModel {
  func getSearchResults() {
    
  }
}

// Search
extension SearchBookViewModel {
  
  // RxDataSource
  func fetchSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) {
    let bookrequest = BookRequest(api: api, query: query, page: page, sort: sort)
    
    searchBookUseCase.searchBookSingle(bookRequest: bookrequest)
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] result in
        guard let self else { return }
        switch result {
        case .success(let value):
          let books = value.books.map { SearchBookSectionItem2.bodyItem(book: $0) }
          let headerSection = SearchBookSectionModel2.headerSection(items: [.headerItem(api: api)])
          
          var updatedSections = self.output.dataSource.value
          
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
          
          self.output.dataSource.accept(updatedSections)
          
        case .failure(let error):
          print(error.localizedDescription)
        }
      }, onFailure: { error in
        print(error.localizedDescription)
      })
      .disposed(by: disposeBag)
  }
  
  // async await
  func getSearchResultsAsync(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
    let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
    let bookResponse = try await searchBookUseCase.execute(<#SearchBookUseCase#>).searchBookAsync(bookrequest: bookRequest)
    return bookResponse
  }
  
  private func resetProperties() {
    input.query = PublishRelay<String>()
    
    searchPage.accept(1)
  }
  
  private func setupInitialSections() {
    let headerItems: [SearchBookSectionItem2] = [
      .headerItem(api: .naver),
      .headerItem(api: .kakao)
    ]
    let bodyItems: [SearchBookSectionItem2] = [
      
    ]
    
    
    let headerSection = SearchBookSectionModel2.headerSection(items: headerItems)
    var updatedSections = output.dataSource.value
    
    updatedSections.removeAll { if case .headerSection = $0 { return true }; return false }
    updatedSections.insert(headerSection, at: 0)
    
    output.dataSource.accept(updatedSections)
  }
  
}





// Save
extension SearchBookViewModel {
  func saveBook(book: Book) {
    saveBookUseCase.executeSave(book: book)
    
    // 리스트에 적용
    
  }
  
  func deleteBook(book: Book) {
    saveBookUseCase.executeDelete(book: book)
    
    // 리스트에 적용
    
  }
}
