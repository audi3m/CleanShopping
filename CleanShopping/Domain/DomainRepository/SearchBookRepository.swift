//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol SearchBookRepository {
  func searchBook()
  func searchBookSingle()
  func searchBookAsync()
  
//  func searchBook(api: BookAPI, query: String, page: Int, sort: SortOption)
//  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
//  func searchBookAsync(bookrequest: BookRequest) async throws -> BookResponse
  
}
