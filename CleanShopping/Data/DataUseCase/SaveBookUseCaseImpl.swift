//
//  SaveBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import SwiftData 

final class FetchSavedBooksUseCaseImpl: FetchSavedBooksUseCase {
  
  private let repository: SaveBookRepository
  
  init(repository: SaveBookRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> [Book] {
    do {
      return try await repository.fetchBooks()
    } catch {
      throw LocalDataBaseError.useCase(.fetch(original: error))
    }
  }
  
}

final class ToggleLikeUseCaseImpl: ToggleLikeUseCase {
  
  private let repository: SaveBookRepository
  
  init(repository: SaveBookRepository) {
    self.repository = repository
  }
  
  func execute(currentLike: Bool, book: Book) async throws {
    do {
      if currentLike {
        try await repository.deleteBook(book: book)
      } else {
        await repository.saveBook(book: book)
      }
    } catch {
      throw LocalDataBaseError.useCase(.save(original: error))
    }
  }
  
}
