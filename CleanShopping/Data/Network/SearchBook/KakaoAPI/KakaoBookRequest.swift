//
//  KakaoRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct KakaoBookRequestParameters: BookRequestProtocol {
    let query: String
    let sort: KakaoBookSortOptions
    let page: Int // 페이지 번호 1 + (n-1) * size
    let size: Int // 20개씩
    
    init(query: String, sort: KakaoBookSortOptions, page: Int, size: Int = 20) {
        self.query = query
        self.sort = sort
        self.page = page
        self.size = size
    }
}

enum KakaoBookSortOptions: String {
    case accuracy
    case latest
}
