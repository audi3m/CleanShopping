//
//  NaverRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct NaverBookRequestParameters {
    let query: String
    let display: Int
    let start: Int
    let sort: NaverSort
    
    init(query: String, display: Int = 20, start: Int, sort: NaverSort = .sim) {
        self.query = query
        self.display = display
        self.start = start
        self.sort = sort
    }
}

enum NaverSort: String {
    case sim = "sim"
    case date = "date"
}
