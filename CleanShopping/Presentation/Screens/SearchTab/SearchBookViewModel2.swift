//
//  SearchBookViewModel2.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift

final class SearchBookViewModel2 {
  
  private let searchBookUseCase: SearchBookUseCase
  private let saveBookUseCase: SaveBookUseCase
  private let disposeBag = DisposeBag()
  
  init(searchBookUseCase: SearchBookUseCase, saveBookUseCase: SaveBookUseCase) {
    self.searchBookUseCase = searchBookUseCase
    self.saveBookUseCase = saveBookUseCase
  }
  
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  
}

extension SearchBookViewModel2 {
  func transform(input: Input) -> Output {
    return Output()
  }
}

// search
extension SearchBookViewModel2 {
  
}

// save
extension SearchBookViewModel2 {
  
}

extension SearchBookViewModel2 {
  
}

extension SearchBookViewModel2 {
  
}
