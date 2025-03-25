//
//  SaveBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation
import SwiftData

final class SaveBookUseCaseImpl: SaveBookUseCase {
  
  private let repository: SaveBookRepository
  
  init(repository: SaveBookRepository) {
    self.repository = repository
  }
  
  func executeFetch() async throws -> [Book] {
    return try await repository.fetchBooks()
  }
  
  func executeSave(book: Book) async throws {
    try await repository.saveBook(book: book)
  }
  
  func executeDelete(book: Book) async throws {
    try await repository.deleteBook(book: book)
  }
  
}
