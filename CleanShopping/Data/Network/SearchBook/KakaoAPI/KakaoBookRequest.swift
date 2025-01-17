//
//  KakaoRequest.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

// parameters
// query: String
// sort: String
// page: Int
// size: Int
// target: String

struct KakaoBookRequestParameter {
    let query: String
    let display = "20"
    let start: String
    let sort: KakaoSort
    let target: KakaoTarget
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
