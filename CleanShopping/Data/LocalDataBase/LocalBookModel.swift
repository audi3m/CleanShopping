//
//  LocalBookModel.swift
//  CleanShopping
//
//  Created by J Oh on 3/7/25.
//

import Foundation
import SwiftData

@Model
final class LocalBookModel {
  var id = UUID()
  var title: String
  var link: String
  var image: String
  var author: String
  var discount: String?
  var publisher: String
  var pubdate: String
  var isbn: String
  var desc: String
  
  init(title: String, link: String, image: String, author: String, discount: String? = nil, publisher: String, pubdate: String, isbn: String, desc: String) {
    self.title = title
    self.link = link
    self.image = image
    self.author = author
    self.discount = discount
    self.publisher = publisher
    self.pubdate = pubdate
    self.isbn = isbn
    self.desc = desc
  }
  
}

