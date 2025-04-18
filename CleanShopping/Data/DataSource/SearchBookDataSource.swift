//
//  SearchBookDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation
import RxSwift

protocol SearchBookDataSource {
  func searchBookSingle(bookRequest: BookRequest) -> Single<Result<BookResponseProtocol, BookRequestError>>
}

final class BookRemoteDataSourceImpl: SearchBookDataSource {
  private let networkManager: BookNetworkManager
  init(networkManager: BookNetworkManager) {
    self.networkManager = networkManager
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
