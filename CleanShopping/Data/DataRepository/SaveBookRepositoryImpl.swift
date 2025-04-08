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
    do {
      let list = try await dataSource.fetchBooks().map { LocalBookMapper.toDomain($0) }
      return list
    } catch {
      throw LocalDataBaseError.repository(.fetch(original: error))
    }
  }
  
  func saveBook(book: Book) async {
      let newBook = LocalBookMapper.toDTO(book)
      await dataSource.saveBook(book: newBook)
  }
  
  //  func updateBook() { }
  
  func deleteBook(book: Book) async throws {
    do {
      try await dataSource.deleteBook(isbn: book.isbn)
    } catch {
      throw LocalDataBaseError.repository(.delete(original: error))
    }
  }
  
}
