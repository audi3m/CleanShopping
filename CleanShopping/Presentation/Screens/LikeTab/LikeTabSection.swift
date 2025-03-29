//
//  LikeTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 3/29/25.
//

import Foundation
import RxDataSources

enum LikeBookSectionItem: Hashable {
  case body(Book)
}

enum LikeBookSection: Int, CaseIterable {
  case body
}

// RxDataSource
enum LikeBookSectionItem2: IdentifiableType, Equatable {
  case bodyItem(Book)
  
  var identity: String {
    switch self {
    case .bodyItem(let book):
      return book.identity.uuidString
    }
  }
}

struct LikeBookSectionModel2 {
  var header: String
  var items: [LikeBookSectionItem2]
}

extension LikeBookSectionModel2: AnimatableSectionModelType {
  init(original: LikeBookSectionModel2, items: [LikeBookSectionItem2]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return header
  }
}

