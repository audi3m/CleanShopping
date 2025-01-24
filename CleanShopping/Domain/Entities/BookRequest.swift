//
//  BookRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/22/25.
//

import Foundation

struct BookRequest {
    let api: BookAPI
    let query: String
    let page: Int
//    let sort: SortOption
}

extension BookRequest {
    func toDTO() -> BookRequestProtocol {
        switch api {
        case .naver:
            return NaverBookRequestParameters(query: query,
                                              display: 20,
                                              start: 1 + (page - 1) * 20,
                                              sort: .sim)
        case .kakao:
            return KakaoBookRequestParameters(query: query,
                                              sort: .accuracy,
                                              page: page,
                                              size: 20)
        }
    }
}

//enum SortOption {
//    case date
//    case accuracy
//}
