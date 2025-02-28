//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 2/28/25.
//

import Foundation
import RxSwift

protocol SearchBookRepository {
  func searchBook(api: BookAPI, query: String, page: Int, sort: SortOption)
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
  func searchBookAsync(bookrequest: BookRequest) async throws -> BookResponse 
}
