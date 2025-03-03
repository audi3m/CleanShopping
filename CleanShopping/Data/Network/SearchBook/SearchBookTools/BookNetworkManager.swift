//
//  BookNetworkManager.swift
//  CleanShopping
//
//  Created by J Oh on 1/15/25.
//

import Foundation
import Alamofire

final class BookNetworkManager {
  static let shared = BookNetworkManager()
  private init() { }
}

extension BookNetworkManager {
  
  func asyncRequest<T: Decodable>(target: SearchBookRouter, of type: T.Type) async throws -> T {
    let request = try target.asURLRequest()
    return try await withCheckedThrowingContinuation { continuation in
      AF.request(request)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let value):
            continuation.resume(returning: value)
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    }
  }
  
  func request<T: Decodable>(target: SearchBookRouter,
                             of type: T.Type,
                             handler: @escaping (Result<T, Error>) -> Void) {
    do {
      let request = try target.asURLRequest()
      AF.request(request)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case .success(let value):
            handler(.success(value))
          case .failure(let error):
            handler(.failure(error))
          }
        }
    } catch {
      print(error)
    }
  }
  
}
