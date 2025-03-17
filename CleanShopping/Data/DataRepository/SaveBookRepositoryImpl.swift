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
  
  func fetchBooks() async -> [Book] {
    return await dataSource.fetchBooks().map { LocalBookMapper.toDomain($0) }
  }
  
  func saveBook(book: Book) async {
    let newBook = LocalBookMapper.toDTO(book)
    await dataSource.saveBook(book: newBook)
  }
  
//  func updateBook() { }
  
  func deleteBook(book: Book) async {
    let isbn = book.isbn
    await dataSource.deleteBook(by: isbn)
  }
  
}
