//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

protocol SearchBookRepository {
  func searchBook()
  func searchBookSingle()
  func searchBookAsync()
  
//  func searchBook(api: BookAPI, query: String, page: Int, sort: SortOption)
//  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
//  func searchBookAsync(bookrequest: BookRequest) async throws -> BookResponse
  
}

final class SearchRepositoryImpl: SearchBookRepository {
  
  private let dataSource: BookRemoteDataSource
  
  init(dataSource: BookRemoteDataSource) {
    self.dataSource = dataSource
  }
  
  func searchBook() {
    dataSource.searchBooks()
  }
  
  func searchBookSingle() {
    dataSource.searchBooks()
  }
  
  func searchBookAsync() {
    dataSource.searchBooks()
  }
  
}
