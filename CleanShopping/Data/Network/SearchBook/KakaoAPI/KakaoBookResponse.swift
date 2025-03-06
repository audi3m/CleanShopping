//
//  KakaoResponse.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct KakaoBookResponseDTO: Decodable {
  let meta: KakaoMetaDTO
  let documents: [KakaoDocumentDTO]
  
  func toDomain() -> BookResponse {
    return BookResponse(totalCount: meta.totalCount,
                        books: documents.map { $0.toDomain() },
                        isEnd: meta.isEnd)
  }
}

struct KakaoMetaDTO: Decodable {
  let totalCount: Int // 총 결과 수
  let pageableCount: Int
  let isEnd: Bool
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case pageableCount = "pageable_count"
    case isEnd = "is_end"
  }
}

struct KakaoDocumentDTO: Decodable, BookDTOProtocol {
  let title: String
  let contents: String
  let url: String // 상세
  let isbn: String
  let datetime: String
  let authors: [String]
  let publisher: String
  let translators: [String]
  let price: Int
  let sale_price: Int
  let thumbnail: String // 표지
  let status: String
  
  func toDomain() -> Book {
    return Book(title: title,
                link: url,
                image: thumbnail,
                author: authors.joined(separator: ", "),
                discount: String(price),
                publisher: publisher,
                pubdate: datetime,
                isbn: isbn,
                description: contents)
  }
}

enum KakaoBookResponseError: Error {
  case responseError
}
