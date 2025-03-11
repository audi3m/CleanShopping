//
//  SearchBookDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation
import RxSwift

protocol SearchBookDataSource {
  func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponseProtocol, BookRequestError>) -> Void)
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponseProtocol, BookRequestError>>
  func searchBookAsync(bookRequest: BookRequest) async throws -> BookResponseProtocol
}

final class BookRemoteDataSourceImpl: SearchBookDataSource {
  
  private let networkManager: BookNetworkManager
  
  init(networkManager: BookNetworkManager) {
    self.networkManager = networkManager
  }
  
}

// @escaping
extension BookRemoteDataSourceImpl {
  func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponseProtocol, BookRequestError>) -> Void) {
    switch bookRequest.api {
    case .naver:
      let params = bookRequest.toDTO() as! NaverBookRequestParameters
      networkManager.request(target: .naver(param: params), of: NaverBookResponseDTO.self) { result in
        switch result {
        case .success(let value):
          handler(.success(value))
        case .failure:
          handler(.failure(.badRequest))
        }
      }
    case .kakao:
      let params = bookRequest.toDTO() as! KakaoBookRequestParameters
      networkManager.request(target: .kakao(param: params), of: KakaoBookResponseDTO.self) { result in
        switch result {
        case .success(let value):
          handler(.success(value))
        case .failure:
          handler(.failure(.badRequest))
        }
      }
    }
  }
}

// Single
extension BookRemoteDataSourceImpl {
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponseProtocol, BookRequestError>> {
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
            single(.success(.success(value)))
          case .failure(let error):
            single(.failure(error))
          }
        }
        
      case .kakao:
        let params = bookRequest.toDTO() as! KakaoBookRequestParameters
        self.networkManager.request(target: .kakao(param: params), of: KakaoBookResponseDTO.self) { result in
          switch result {
          case .success(let value):
            single(.success(.success(value)))
          case .failure(let error):
            single(.failure(error))
          }
        }
      }
      
      return Disposables.create()
    }
  }
}

// async/await
extension BookRemoteDataSourceImpl {
  func searchBookAsync(bookRequest: BookRequest) async throws -> BookResponseProtocol {
    switch bookRequest.api {
    case .naver:
      let params = bookRequest.toDTO() as! NaverBookRequestParameters
      let response = try await networkManager.requestAsync(target: .naver(param: params), of: NaverBookResponseDTO.self)
      return response
    case .kakao:
      let params = bookRequest.toDTO() as! KakaoBookRequestParameters
      let response = try await networkManager.requestAsync(target: .kakao(param: params), of: KakaoBookResponseDTO.self)
      return response
    }
  }
}
