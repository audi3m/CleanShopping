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
  
  func executeFetch() -> [Book] {
    return repository.fetchBooks()
  }
  
  func executeSave(book: Book) {
    repository.saveBook(book: book)
  }
  
  func executeDelete(book: Book) {
    repository.deleteBook(book: book)
  }
  
}
