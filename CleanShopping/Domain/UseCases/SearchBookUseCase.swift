//
//  SearchBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SearchBookUseCase {
  func execute(api: BookAPI, query: String, page: Int, sort: SortOption) -> BookResponse
}
