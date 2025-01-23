//
//  NaverRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct NaverBookRequestParameters: BookRequestProtocol {
    let query: String
    let display: Int // 20개씩
    let start: Int // 시작 번호
    let sort: NaverBookSortOptions
    
    init(query: String, display: Int = 20, start: Int, sort: NaverBookSortOptions) {
        self.query = query
        self.display = display
        self.start = start
        self.sort = sort
    }
}

enum NaverBookSortOptions: String {
    case sim = "sim"
    case date = "date"
}
