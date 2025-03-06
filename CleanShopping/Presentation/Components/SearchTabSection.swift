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
  case headerItem(api: BookAPI)
  case bodyItem(book: Book)
}

enum SearchBookSectionModel2 {
  case headerSection(items: [SearchBookSectionItem2])
  case bodySection(items: [SearchBookSectionItem2])
}

extension SearchBookSectionModel2: SectionModelType {
  typealias Item = SearchBookSectionItem2
  
  var items: [SearchBookSectionItem2] {
    switch self {
    case .headerSection(let items):
      return items
    case .bodySection(let items):
      return items
    }
  }
  
  init(original: SearchBookSectionModel2, items: [SearchBookSectionItem2]) {
    switch original {
    case .headerSection:
      self = .headerSection(items: items)
    case .bodySection:
      self = .bodySection(items: items)
    }
  }
}
