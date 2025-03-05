//
//  SaveBookUseCaseImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

final class SaveBookUseCaseImpl: SaveBookUseCase {
  
  private let repository: LocalBookRepository
  
  init(repository: LocalBookRepository) {
    self.repository = repository
  }
  
  func executeFetch() {
    repository.fetchBooks()
  }
  
  func executeSave(book: Book) {
    repository.saveBook()
  }
  
  func executeUpdate(book: Book) {
    repository.updateBook()
  }
  
  func executeDelete(book: Book) {
    repository.deleteBook()
  }
  
}
