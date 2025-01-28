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
    
    func searchKakaoBook(params: KakaoBookRequestParameters) {
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
    
    func searchNaverBook(params: NaverBookRequestParameters) {
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
