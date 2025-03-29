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

// Model 2
// RxDataSource
enum SearchBookSectionItem2: IdentifiableType, Equatable {
  case headerItem(BookAPI)
  case bodyItem(Book)
  //  case thirdSection(Model)
  
  var identity: String {
    switch self {
    case .headerItem(let api):
      return api.identity
    case .bodyItem(let book):
      return book.identity.uuidString
    }
  }
}

struct SearchBookSectionModel2 {
  var header: String
  var items: [SearchBookSectionItem2]
}

extension SearchBookSectionModel2: AnimatableSectionModelType {
  init(original: SearchBookSectionModel2, items: [SearchBookSectionItem2]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return header
  }
}
