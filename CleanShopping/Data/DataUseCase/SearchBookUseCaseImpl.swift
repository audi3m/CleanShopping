//
//  SearchBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import RxSwift

final class SearchBookUseCaseImpl: SearchBookUseCase {
  
  private let repository: SearchBookRepository
  
  init(repository: SearchBookRepository) {
    self.repository = repository
  }
  
  func executeSearch(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>> {
    return repository.searchBookSingle(bookRequest: bookRequest)
  }
  
}
