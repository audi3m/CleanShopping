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
  case headerItem(BookAPI)
  case bodyItem(Book)
//  case thirdSection
}

struct SearchBookSectionModel2 {
  var header: String
  var items: [SearchBookSectionItem2]
}

extension SearchBookSectionModel2: SectionModelType {
  init(original: SearchBookSectionModel2, items: [SearchBookSectionItem2]) {
    self = original
    self.items = items
  }
}
