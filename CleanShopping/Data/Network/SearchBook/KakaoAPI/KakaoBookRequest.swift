//
//  KakaoRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct KakaoBookRequestParameters {
    let query: String
    let sort: KakaoSort
    let page: Int
    let size: Int
    let target: KakaoTarget?
    
    init(query: String, sort: KakaoSort = .accuracy, page: Int, size: Int = 20, target: KakaoTarget? = nil) {
        self.query = query
        self.sort = sort
        self.page = page
        self.size = size
        self.target = target
    }
}

enum KakaoSort: String {
    case accuracy
    case latest
}

// title(제목), isbn (ISBN), publisher(출판사), person(인명)
enum KakaoTarget: String {
    case title
    case isbn
    case publisher
    case person
}
