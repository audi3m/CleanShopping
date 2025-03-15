//
//  SearchBookViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchBookViewModel {
  
  private let searchBookUseCase: SearchBookUseCase
  private let saveBookUseCase: SaveBookUseCase
  private let disposeBag = DisposeBag()
  
  var input = Input()
  var output = Output()
  
  init(searchBookUseCase: SearchBookUseCase, saveBookUseCase: SaveBookUseCase) {
    self.searchBookUseCase = searchBookUseCase
    self.saveBookUseCase = saveBookUseCase
    
    initDataSource()
    transform()
  }
  
}

// Transform
extension SearchBookViewModel: InOutViewModel {
  
  struct Input {
    let searchAPI = BehaviorRelay<BookAPI>(value: .naver)
    let searchQuery = BehaviorRelay<String>(value: "")
    let searchPage = BehaviorRelay<Int>(value: 1)
    let searchSort = BehaviorRelay<SortOption>(value: .accuracy)
    let searchButtonClicked = PublishRelay<Void>()
    let loadMore = PublishRelay<Void>()
  }
  
  struct Output {
    let dataSource = BehaviorRelay<[SearchBookSectionModel2]>(value: [])
    let isEndPage = BehaviorRelay<Bool>(value: false)
    let optionChanged = PublishRelay<Void>()
  }
  
  func transform() {
    let bookRequest = Observable
      .combineLatest(input.searchAPI,
                     input.searchQuery,
                     input.searchPage,
                     input.searchSort)
      .map { api, query, page, sort in
        BookRequest(api: api, query: query, page: page, sort: sort)
      }
    
    input.searchButtonClicked
      .withLatestFrom(bookRequest)
      .bind(with: self) { owner, bookRequest in
        owner.resetSearch()
        owner.searchBook(bookRequest: bookRequest)
      }
      .disposed(by: disposeBag)
      
    input.loadMore
      .withLatestFrom(bookRequest)
      .bind(with: self) { owner, bookRequest in
        if !owner.output.isEndPage.value {
          owner.input.searchPage.accept(owner.input.searchPage.value + 1)
          owner.searchBook(bookRequest: bookRequest)
        }
      }
      .disposed(by: disposeBag)
    
    Observable.combineLatest(input.searchAPI, input.searchSort)
      .map { _ in }
      .bind(to: output.optionChanged)
      .disposed(by: disposeBag)
    
  }
  
}

// Search
extension SearchBookViewModel {
  
  private func searchBook(bookRequest: BookRequest) {
    searchBookUseCase.executeSearch(bookRequest: bookRequest)
      .asDriver(onErrorJustReturn: .failure(.badRequest))
      .drive(with: self) { owner, result in
        switch result {
        case .success(let data):
          owner.addItemsToBodySection(newBooks: data.books)
          if data.isEnd {
            owner.output.isEndPage.accept(true)
          }
        case .failure(let error):
          print("Error fetching books:", error)
        }
      } onCompleted: { _ in
        print("Book search onCompleted")
      } onDisposed: { _ in
        print("Book search onDisposed")
      }
      .disposed(by: disposeBag)
  }
  
  private func resetSearch() {
    input.searchPage.accept(1)
    eraseItemsFromBodySection()
  }
  
  private func initDataSource() {
    let headerSection = SearchBookSectionModel2(
      header: "Header Section",
      items: [.headerItem(.naver), .headerItem(.kakao)]
    )
    
    let bodySection = SearchBookSectionModel2(
      header: "Body Section",
      items: []
    )
    
    output.dataSource.accept([headerSection, bodySection])
  }
  
  private func addItemsToBodySection(newBooks: [Book]) {
    var currentSections = output.dataSource.value
    let newItems = newBooks.map { SearchBookSectionItem2.bodyItem($0) }
    guard let bodyIndex = currentSections.firstIndex(where: { $0.header == "Body Section" }) else { return }
    
    let updatedItems = currentSections[bodyIndex].items + newItems
    currentSections[bodyIndex] = SearchBookSectionModel2(header: "Body Section", items: updatedItems)
    
    output.dataSource.accept(currentSections)
  }
  
  private func eraseItemsFromBodySection() {
    var currentSections = output.dataSource.value
    guard let bodyIndex = currentSections.firstIndex(where: { $0.header == "Body Section" }) else { return }
    
    currentSections[bodyIndex].items.removeAll()
    output.dataSource.accept(currentSections)
  }
  
}

// Save
extension SearchBookViewModel {
  
}
