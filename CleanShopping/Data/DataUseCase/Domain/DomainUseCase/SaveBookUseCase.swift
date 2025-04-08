//
//  SaveBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol FetchSavedBooksUseCase {
  func execute() async throws -> [Book]
}

protocol ToggleLikeUseCase {
  func execute(currentLike: Bool, book: Book) async throws
}
