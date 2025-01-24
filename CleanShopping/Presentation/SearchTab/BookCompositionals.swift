//
//  Compositionals.swift
//  CleanShopping
//
//  Created by J Oh on 1/24/25.
//

import Foundation

enum SearchBookSection: CaseIterable {
    case searchResultSection
}

enum BookSectionItem: Hashable {
    case searchResult(Book)
}
