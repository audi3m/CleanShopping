//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift

protocol SearchBookRepository {
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
}
