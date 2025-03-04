//
//  BookRemoteDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation

protocol BookRemoteDataSourceProtocol {
  func saveBook()
  func deleteBook()
  func getCachedBooks()
}

final class BookRemoteDataSource: BookRemoteDataSourceProtocol {
  func saveBook() { }
  func deleteBook() { }
  func getCachedBooks() { }
}
