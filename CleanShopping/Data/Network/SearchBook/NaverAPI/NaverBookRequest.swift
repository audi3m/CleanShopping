//
//  NaverRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct NaverBookRequestParameter {
    let query: String
    let display = "20"
    let start: String
    let sort: NaverSort
}

enum NaverSort: String {
    case sim = "sim"
    case date = "date"
}
