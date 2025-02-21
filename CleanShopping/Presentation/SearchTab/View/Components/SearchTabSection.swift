//
//  SearchTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import Foundation
import RxDataSources

enum SearchBookSectionItem: Hashable {
  case filterOption(BookAPI)
  case listData(Book)
}

enum SearchBookSection: Int, CaseIterable {
  case filter
  case list
}



// RxDataSource

enum SearchBookSectionItem2 {
//  case header(model: BookAPI)
  case body(model: Book)
}

enum SearchBookSectionModel {
//  case headerSection(items: BookAPI.AllCases)
  case bodySection(items: [SearchBookSectionItem2])
}

extension SearchBookSectionModel: SectionModelType {
  
  typealias Item = SearchBookSectionItem2
  
  var items: [SearchBookSectionItem2] {
    switch self {
//    case .headerSection(let apis):
//      return apis
    case .bodySection(let books):
      return books
    }
  }
  
  init(original: SearchBookSectionModel, items: [SearchBookSectionItem2]) {
    self = original
  }
  
}
