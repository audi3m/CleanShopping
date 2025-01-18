//
//  NaverResponse.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct NaverBookResponseDTO: Decodable, BookResponseProtocol {
    let lastBuildDate: String // 검색 결과 생성 시간
    let total: Int // 총 결과 수
    let start: Int // 시작 페이지
    let display: Int // 한 페이지당 문서 수
    let items: [NaverBookDTO]
    
    func toDomain() -> BookResponse {
        return BookResponse(totalCount: total,
                            books: items.map { $0.toDomain() })
    }
}

struct NaverBookDTO: Decodable, BookDTOProtocol {
    let title: String
    let link: String // 상세
    let image: String // 표지
    let author: String
    let discount: String
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
    
    func toDomain() -> Book {
        return Book(title: title,
                    link: link,
                    image: image,
                    author: author,
                    discount: discount,
                    publisher: publisher,
                    pubdate: pubdate,
                    isbn: isbn,
                    description: description)
    }
}
