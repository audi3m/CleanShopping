//
//  SearchBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

final class SearchBookUseCaseImpl: SearchBookUseCase {
  private let repository: SearchBookRepository
  
  init(repository: SearchBookRepository) {
    self.repository = repository
  }
  
  func execute(api: BookAPI, query: String, page: Int, sort: SortOption) -> BookResponse {
    let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
    let response = repository.searchBookSingle(bookRequest: bookRequest)
    
    //
    return BookResponse(totalCount: 0, books: [], isEnd: false)
  }
  
  
}
