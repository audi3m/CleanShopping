//
//  BookMapper.swift
//  CleanShopping
//
//  Created by J Oh on 3/9/25.
//

import Foundation

// Local DB
struct LocalBookMapper {
  static func toDTO(_ book: Book) -> LocalBookModel {
    return LocalBookModel(title: book.title,
                          link: book.link,
                          image: book.image,
                          author: book.author,
                          discount: book.discount,
                          publisher: book.publisher,
                          pubdate: book.pubdate,
                          isbn: book.isbn,
                          desc: book.description)
  }
  
  static func toDomain(_ localBook: LocalBookModel) -> Book {
    return Book(title: localBook.title,
                link: localBook.link,
                image: localBook.image,
                author: localBook.author,
                discount: localBook.discount,
                publisher: localBook.publisher,
                pubdate: localBook.pubdate,
                isbn: localBook.isbn,
                description: localBook.desc)
  }
}

// Network
struct NetworkBookMapper {
  static func toDomainResponse(response: NaverBookResponseDTO) -> BookResponse {
    return BookResponse(totalCount: response.total,
                        books: response.items.map { self.toDomainBook(dto: $0) },
                        isEnd: response.total <= response.start + response.display)
  }
  
  static func toDomainResponse(response: KakaoBookResponseDTO) -> BookResponse {
    return BookResponse(totalCount: response.meta.totalCount,
                        books: response.documents.map { self.toDomainBook(dto: $0) },
                        isEnd: response.meta.isEnd)
  }
  
  static func toDomainBook(dto: NaverBookDTO) -> Book {
    return Book(title: dto.title,
                link: dto.link,
                image: dto.image,
                author: dto.author,
                discount: dto.discount,
                publisher: dto.publisher,
                pubdate: dto.pubdate,
                isbn: dto.isbn,
                description: dto.description)
  }
  
  static func toDomainBook(dto: KakaoDocumentDTO) -> Book {
    return Book(title: dto.title,
                link: dto.url,
                image: dto.thumbnail,
                author: dto.authors.joined(separator: ", "),
                discount: String(dto.price),
                publisher: dto.publisher,
                pubdate: dto.datetime,
                isbn: dto.isbn,
                description: dto.contents)
  }
  
  
}
