//
//  SaveBookRepositoryImpl.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

final class SaveBookRepositoryImpl: SaveBookRepository {
  
  private let dataSource: SaveBookDataSource
  
  init(dataSource: SaveBookDataSource) {
    self.dataSource = dataSource
  }
  
  func fetchBooks() async throws -> [Book] {
    return try await dataSource.fetchBooks().map { LocalBookMapper.toDomain($0) }
  }
  
  func saveBook(book: Book) async throws {
    let newBook = LocalBookMapper.toDTO(book)
    try await dataSource.saveBook(book: newBook)
  }
  
  //  func updateBook() { }
  
  func deleteBook(book: Book) async throws {
    try await dataSource.deleteBook(by: book.isbn)
  }
  
}
