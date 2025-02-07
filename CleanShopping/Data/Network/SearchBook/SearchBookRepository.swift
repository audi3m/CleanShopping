//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 1/25/25.
//

import Foundation

final class SearchBookRepository {
    static let shared = SearchBookRepository()
    
    private let networkManager: BookNetworkManager
    
    private init(networkManager: BookNetworkManager = BookNetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension SearchBookRepository {
    
    func searchBook(bookRequest: BookRequest, handler: @escaping (Result<BookResponse, Error>) -> Void) {
        switch bookRequest.api {
        case .naver:
            let params = bookRequest.toDTO() as! NaverBookRequestParameters
            networkManager.request(target: .naver(param: params), of: NaverBookResponseDTO.self) { result in
                switch result {
                case .success(let value):
                    handler(.success(value.toDomain()))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        case .kakao:
            let params = bookRequest.toDTO() as! KakaoBookRequestParameters
            networkManager.request(target: .kakao(param: params), of: KakaoBookResponseDTO.self) { result in
                switch result {
                case .success(let value):
                    handler(.success(value.toDomain()))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
    }
    
    func newSearchBook(bookRequest: BookRequest) async throws -> BookResponse {
        switch bookRequest.api {
        case .naver:
            let params = bookRequest.toDTO() as! NaverBookRequestParameters
            let response = try await networkManager.newRequest(target: .naver(param: params), of: NaverBookResponseDTO.self)
            return response.toDomain()
        case .kakao:
            let params = bookRequest.toDTO() as! KakaoBookRequestParameters
            let response = try await networkManager.newRequest(target: .kakao(param: params), of: KakaoBookResponseDTO.self)
            return response.toDomain()
        }
    }
    
}
