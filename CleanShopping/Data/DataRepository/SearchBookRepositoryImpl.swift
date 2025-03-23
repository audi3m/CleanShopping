//
//  SearchBookRepositoryImpl.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

enum BookRequestError: Error {
  case badRequest
  case badResponse
}

final class SearchBookRepositoryImpl: SearchBookRepository {
  
  private let dataSource: SearchBookDataSource
  
  init(dataSource: SearchBookDataSource) {
    self.dataSource = dataSource
  }
  
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>> {
    return dataSource.searchBookSingle(bookRequest: bookRequest)
      .flatMap { result -> Single<Result<BookResponse, BookRequestError>> in
        switch result {
        case .success(let response):
          if let naverResponse = response as? NaverBookResponseDTO {
            return .just(.success(NetworkBookMapper.toDomainResponse(response: naverResponse)))
          } else if let kakaoResponse = response as? KakaoBookResponseDTO {
            return .just(.success(NetworkBookMapper.toDomainResponse(response: kakaoResponse)))
          } else {
            return .just(.failure(BookRequestError.badResponse))
          }
        case .failure(let error):
          return .just(.failure(error))
        }
      }
  }
  
}
