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
}

final class SearchBookRepositoryImpl: SearchBookRepository {
  
  private let dataSource: SearchBookDataSource
  
  init(dataSource: SearchBookDataSource) {
    self.dataSource = dataSource
  }
  
  func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponse, Error>) -> Void) {
    dataSource.searchBook(bookRequest: bookRequest) { result in
      switch result {
      case .success(let response):
        handler(.success(response.toDomain()))
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func searchBookSingle(bookRequest: BookRequest) -> Single<BookResponse> {
    return dataSource.searchBookSingle(bookRequest: bookRequest)
      .flatMap { result -> Single<BookResponse> in
        switch result {
        case .success(let response):
          if let naverResponse = response as? NaverBookResponseDTO {
            return .just(NetworkBookMapper.toDomainResponse(response: naverResponse))
          } else if let kakaoResponse = response as? KakaoBookResponseDTO {
            return .just(NetworkBookMapper.toDomainResponse(response: kakaoResponse))
          } else {
            return .error(BookRequestError.badRequest)
          }
        case .failure(let error):
          return .error(error)
        }
      }
  }
  
  func searchBookAsync(bookRequest: BookRequest) {
    
  }
  
  
  
}
