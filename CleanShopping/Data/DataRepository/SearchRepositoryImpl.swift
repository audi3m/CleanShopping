//
//  SearchRepositoryImpl.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

final class SearchRepositoryImpl: SearchBookRepository {
  
  private let dataSource: BookRemoteDataSource
  private let networkManager: BookNetworkManager
  
  init(dataSource: BookRemoteDataSource, networkManager: BookNetworkManager) {
    self.dataSource = dataSource
    self.networkManager = networkManager
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

extension SearchRepositoryImpl {
  
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponse, BookRequestError>> {
    return Single.create { [weak self] single -> Disposable in
      guard let self else {
        single(.success(.failure(.badRequest)))
        return Disposables.create()
      }
      
      switch bookRequest.api {
      case .naver:
        let params = bookRequest.toDTO() as! NaverBookRequestParameters
        self.networkManager.request(target: .naver(param: params), of: NaverBookResponseDTO.self) { result in
          switch result {
          case .success(let value):
            single(.success(.success(value.toDomain())))
          case .failure(let error):
            single(.failure(error))
          }
        }
        
      case .kakao:
        let params = bookRequest.toDTO() as! KakaoBookRequestParameters
        self.networkManager.request(target: .kakao(param: params), of: KakaoBookResponseDTO.self) { result in
          switch result {
          case .success(let value):
            single(.success(.success(value.toDomain())))
          case .failure(let error):
            single(.failure(error))
          }
        }
      }
      
      return Disposables.create()
    }
  }
}

// @escaping
extension SearchRepositoryImpl {
  
  func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponse, BookRequestError>) -> Void) {
    switch bookRequest.api {
    case .naver:
      let params = bookRequest.toDTO() as! NaverBookRequestParameters
      networkManager.request(target: .naver(param: params), of: NaverBookResponseDTO.self) { result in
        switch result {
        case .success(let value):
          handler(.success(value.toDomain()))
        case .failure:
          handler(.failure(.badRequest))
        }
      }
    case .kakao:
      let params = bookRequest.toDTO() as! KakaoBookRequestParameters
      networkManager.request(target: .kakao(param: params), of: KakaoBookResponseDTO.self) { result in
        switch result {
        case .success(let value):
          handler(.success(value.toDomain()))
        case .failure:
          handler(.failure(.badRequest))
        }
      }
    }
  }
  
}
 
// async/await
extension SearchRepositoryImpl {
  func searchBookAsync(bookRequest: BookRequest) async throws -> BookResponse {
    switch bookRequest.api {
    case .naver:
      let params = bookRequest.toDTO() as! NaverBookRequestParameters
      let response = try await networkManager.requestAsync(target: .naver(param: params), of: NaverBookResponseDTO.self)
      return response.toDomain()
    case .kakao:
      let params = bookRequest.toDTO() as! KakaoBookRequestParameters
      let response = try await networkManager.requestAsync(target: .kakao(param: params), of: KakaoBookResponseDTO.self)
      return response.toDomain()
    }
  }
  
}
