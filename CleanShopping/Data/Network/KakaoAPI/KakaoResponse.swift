//
//  KakaoResponse.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct KakaoBookResponseDTO: Decodable {
    let meta: KakaoMeta
    let documents: [KakaoDocument]
}

struct KakaoMetaDTO: Decodable {
    let totalCount: Int
    let pageableCount: Int
    let isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}

struct KakaoDocumentDTO: Decodable {
    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: Date
    let authors: [String]
    let publisher: String
    let translators: [String]
    let price: Int
    let sale_price: Int
    let thumbnail: String
    let status: String
}
