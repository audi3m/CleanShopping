//
//  Book.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation
import Differentiator

struct Book: Identifiable, Hashable, IdentifiableType, Equatable {
  
  let id = UUID()
  let title: String
  let link: String
  let image: String
  let author: String
  let discount: String?
  let publisher: String
  let pubdate: String
  let isbn: String
  let description: String
  
  init(id: UUID = UUID(),
       title: String,
       link: String,
       image: String,
       author: String,
       discount: String?,
       publisher: String,
       pubdate: String,
       isbn: String,
       description: String) {
    self.id = id
    self.title = title
    self.link = link
    self.image = image
    self.author = author
    self.discount = discount
    self.publisher = publisher
    self.pubdate = pubdate
    self.isbn = isbn
    self.description = description
  }
  
  var identity: UUID {
    return self.id
  }
}

extension Book {
  var info: String {
    return "저자 " + author + " | " + "출판 " + publisher + " | " + pubdate
  }
  
  var info2: String {
    return "저자 " + author + "\n" + "출판 " + publisher + "\n" + pubdate.prefix(10)
  }
  
  var price: String {
    if let discount {
      return discount + "원"
    } else {
      return ""
    }
  }
}

extension Book {
  static let sample = Book(title: "",
                           link: "",
                           image: "",
                           author: "",
                           discount: "",
                           publisher: "",
                           pubdate: "",
                           isbn: "",
                           description: "")
}

extension Date {
  func toFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: self)
  }
}
