//
//  LocalBookRepository2.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol LocalBookRepository {
  func fetchBooks()
  func saveBook()
  func updateBook()
  func deleteBook()
}
