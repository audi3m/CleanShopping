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
    
    func searchKakaoBook(bookRequest: BookRequest) {
        let params = KakaoBookRequestParameters(query: bookRequest.query, page: bookRequest.page)
        networkManager.request(target: .kakao(param: params),
                               of: KakaoBookResponseDTO.self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func searchNaverBook(bookRequest: BookRequest) {
        let params = NaverBookRequestParameters(query: bookRequest.query, start: bookRequest.page)
        networkManager.request(target: .naver(param: params),
                               of: NaverBookResponseDTO.self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
