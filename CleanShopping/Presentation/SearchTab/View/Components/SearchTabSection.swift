//
//  SearchTabSection.swift
//  CleanShopping
//
//  Created by J Oh on 2/4/25.
//

import Foundation

enum SearchBookSection: Int, CaseIterable {
    case filter
    case list
}

enum SearchBookSectionItem: Hashable {
    case filterOption(BookAPI)
    case listData(Book)
}
