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
  
  func executeFetch() async -> [Book] {
    return await repository.fetchBooks()
  }
  
  func executeSave(book: Book) async {
    await repository.saveBook(book: book)
  }
  
  func executeDelete(book: Book) async {
    await repository.deleteBook(book: book)
  }
  
}
