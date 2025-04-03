//
//  LikeTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 3/29/25.
//

import Foundation
import RxDataSources

enum LikeBookSection: CaseIterable {
  case body
}

enum LikeBookSectionItem: IdentifiableType, Equatable {
  case bodyItem(Book)
  
  var identity: String {
    switch self {
    case .bodyItem(let book):
      return book.identity.uuidString
    }
  }
}

struct LikeBookSectionModel {
  var header: String
  var items: [LikeBookSectionItem]
}

extension LikeBookSectionModel: AnimatableSectionModelType {
  init(original: LikeBookSectionModel, items: [LikeBookSectionItem]) {
    self = original
    self.items = items
  }
  
  var identity: String {
    return header
  }
}
