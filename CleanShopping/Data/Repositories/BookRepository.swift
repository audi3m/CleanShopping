//
//  BookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

final class BookRepository: BookRepositoryProtocol {
  
  private let remoteDataSource: BookRemoteDataSource
  private let localDataSource: BookLocalDataSource
  
  init(remoteDataSource: BookRemoteDataSource, localDataSource: BookLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }
  
}

// search
extension BookRepository {
  func searchBook() {
    
  }
}

// save
extension BookRepository {
  func saveBook() {
    
  }
  
  func deleteBook() {
    
  }
}




final class SearchBookUseCaseImpl: SearchBookUseCaseProtocol {
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
