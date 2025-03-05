//
//  SearchBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

final class SearchBookUseCaseImpl: SearchBookUseCase {
  
  private let repository: SearchBookRepository
  
  init(repository: SearchBookRepository) {
    self.repository = repository
  }
  
  func executeSearch() {
    repository.searchBook()
//    repository.searchBookSingle()
//    repository.searchBookAsync()
  }
  
}
