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
  
  func fetchBooks() -> [Book] {
    return dataSource.fetchBooks().map { LocalBookMapper.toDomain($0) }
  }
  
  func saveBook(book: Book) {
    let newBook = LocalBookMapper.toDTO(book)
    dataSource.saveBook(book: newBook)
  }
  
//  func updateBook() { }
  
  func deleteBook(book: Book) {
    let id = book.id
    dataSource.deleteBook(by: id)
  }
  
}
