//
//  BookLocalDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation

protocol BookLocalDataSourceProtocol {
  func saveBook()
  func deleteBook()
  func getCachedBooks()
}

final class BookLocalDataSourceImpl: BookLocalDataSourceProtocol {
  func saveBook() { }
  func deleteBook() { }
  func getCachedBooks() { }
}
