//
//  SearchTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import Foundation
import RxDataSources

enum SearchBookSection: CaseIterable {
  case header
  case body
}

enum SearchBookSectionItem: IdentifiableType, Equatable {
  case headerItem(BookAPI)
  case bodyItem(Book)
  
  var identity: String {
    switch self {
    case .headerItem(let api):
      return api.identity
    case .bodyItem(let book):
      return book.identity.uuidString
    }
  }
}

struct SearchBookSectionModel {
  var header: String
  var items: [SearchBookSectionItem]
}

extension SearchBookSectionModel: AnimatableSectionModelType {
  init(original: SearchBookSectionModel, items: [SearchBookSectionItem]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return header
  }
}
