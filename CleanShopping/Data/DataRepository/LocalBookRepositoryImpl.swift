//
//  LocalBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

final class LocalBookRepositoryImpl: LocalBookRepository {
  private let dataSource: BookLocalDataSource
  
  init(dataSource: BookLocalDataSource) {
    self.dataSource = dataSource
  }
  
  func fetchBooks() {
    dataSource.fetchBooks()
  }
  
  func saveBook() {
    dataSource.saveBook()
  }
  
  func updateBook() {
    dataSource.updateBook()
  }
  
  func deleteBook() {
    dataSource.deleteBook()
  }
  
}
