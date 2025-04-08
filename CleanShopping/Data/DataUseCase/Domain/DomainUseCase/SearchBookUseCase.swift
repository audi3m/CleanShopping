//
//  SearchBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

protocol SearchBookUseCase {
  func executeSearch(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>>
}
