//
//  BookLocalDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation

protocol BookLocalDataSource {
  func saveBook()
  func deleteBook()
  func getCachedBooks()
}

final class BookLocalDataSourceImpl: BookLocalDataSource {
  func saveBook() { }
  func deleteBook() { }
  func getCachedBooks() { }
}
