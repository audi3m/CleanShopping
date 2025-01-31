//
//  KakaoRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

protocol SortOptionDTO { }

struct KakaoBookRequestParameters: BookRequestProtocol {
    let query: String
    let sort: KakaoBookSortOptions
    let page: Int // 페이지 번호 1 + (n-1) * size
    let size: Int // 20개씩
    
    init(query: String, sort: KakaoBookSortOptions = .accuracy, page: Int, size: Int = 20) {
        self.query = query
        self.sort = sort
        self.page = page
        self.size = size
    }
}

enum KakaoBookSortOptions: Int {
    case accuracy
    case latest
    
    var asString: String {
        switch self {
        case .accuracy:
            return "accuracy"
        case .latest:
            return "latest"
        }
    }
}
