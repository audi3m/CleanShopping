//
//  BookRemoteDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation

protocol BookRemoteDataSource {
  func saveBook()
  func deleteBook()
  func getCachedBooks()
}

final class BookRemoteDataSourceImpl: BookRemoteDataSource {
  func saveBook() { }
  func deleteBook() { }
  func getCachedBooks() { }
}
