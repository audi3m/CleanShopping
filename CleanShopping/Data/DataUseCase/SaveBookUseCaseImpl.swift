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
    do {
      let list = try await repository.fetchBooks()
      return list
    } catch {
      throw LocalDataBaseError.useCase(.fetch(original: error))
    }
  }
  
  func executeSave(book: Book) async throws {
    do {
      try await repository.saveBook(book: book)
    } catch {
      throw LocalDataBaseError.useCase(.save(original: error))
    }
  }
  
  func executeDelete(book: Book) async throws {
    do {
      try await repository.deleteBook(book: book)
    } catch {
      throw LocalDataBaseError.useCase(.delete(original: error))
    }
  }
  
}
