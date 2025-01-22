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
     
}

extension BookRequest {
    func toDTO(bookRequest: BookRequest) -> BookRequestProtocol {
        switch bookRequest.api {
        case .naver:
            return NaverBookRequestParameters(query: query,
                                              display: 20,
                                              start: <#T##Int#>,
                                              sort: <#T##NaverSort#>)
        case .kakao:
            return KakaoBookRequestParameters(query: query,
                                              sort: <#T##KakaoSort#>,
                                              page: <#T##Int#>,
                                              size: 20)
        }
        
        
    }
}
