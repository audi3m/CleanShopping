//
//  SearchBookViewModel2.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchBookViewModel2 {
  
  private let searchBookUseCase: SearchBookUseCase
  private let saveBookUseCase: SaveBookUseCase
  private let disposeBag = DisposeBag()
  
  init(searchBookUseCase: SearchBookUseCase, saveBookUseCase: SaveBookUseCase) {
    self.searchBookUseCase = searchBookUseCase
    self.saveBookUseCase = saveBookUseCase
  }
  
  
  
}

// Transform
extension SearchBookViewModel2: InOutViewModel {
  
  struct Input {
    let searchAPI = BehaviorSubject<BookAPI>(value: .naver)
    let searchQuery = BehaviorSubject<String>(value: "")
    let searchPage = BehaviorSubject<Int>(value: 1)
    let searchSort = BehaviorSubject<SortOption>(value: .accuracy)
    let searchTrigger = PublishRelay<Void>()
  }
  
  struct Output {
    let results: Driver<[Book]>
  }
  
  func transform(input: Input) -> Output {
    
    return Output(results: <#Driver<[Book]>#>)
  }
  
}

// Search
extension SearchBookViewModel2 {
  // 검색결과 불러오기
  // 초기화
  //
}

// Save
extension SearchBookViewModel2 {
  
}

extension SearchBookViewModel2 {
  
}

extension SearchBookViewModel2 {
  
}
