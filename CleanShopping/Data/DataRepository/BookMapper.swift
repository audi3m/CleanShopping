//
//  BookMapper.swift
//  CleanShopping
//
//  Created by J Oh on 3/9/25.
//

import Foundation

struct BookMapper {
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
    return Book(id: localBook.id,
                title: localBook.title,
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
