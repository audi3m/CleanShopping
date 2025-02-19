//
//  SearchTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import Foundation
import RxDataSources

enum SearchBookSection: Int, CaseIterable {
  case filter
  case list
}

enum SearchBookSectionItem: Hashable {
  case filterOption(BookAPI)
  case listData(Book)
}


// RxDataSource
struct SearchBookHeaderSectionModel {
  var api: BookAPI
}

struct SearchBookBodySectionModel {
  var books: [Book]
}

enum SearchBookSectionModelType {
  case header(SearchBookHeaderSectionModel)
  case body(SearchBookBodySectionModel)
}

struct SearchBookSectionModel {
  var items: [SearchBookSectionModelType]
}

extension SearchBookSectionModel: SectionModelType {
  init(original: SearchBookSectionModel, items: [SearchBookSectionModelType]) {
    self = original
    self.items = items
  }
  
}
