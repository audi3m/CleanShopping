//
//  BookRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/22/25.
//

import Foundation

enum BookAPI {
    case naver
    case kakao
}

enum SortOption: Int {
    case accuracy
    case date
}

struct BookRequest {
    let api: BookAPI
    let query: String
    let page: Int
    let sort: SortOption
}

extension BookRequest {
    func toDTO() -> BookRequestProtocol {
        switch api {
        case .naver:
            return NaverBookRequestParameters(query: query,
                                              display: 20,
                                              start: 1 + (page - 1) * 20,
                                              sort: NaverBookSortOptions(rawValue: sort.rawValue) ?? .sim)
        case .kakao:
            return KakaoBookRequestParameters(query: query,
                                              sort: KakaoBookSortOptions(rawValue: sort.rawValue) ?? .accuracy,
                                              page: page,
                                              size: 20)
        }
    }
}
