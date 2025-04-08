//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift

protocol SearchBookRepository {
//  func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponse, Error>) -> Void)
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
//  func searchBookAsync(bookRequest: BookRequest)
}
