//
//  SaveBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol SaveBookRepository {
  func fetchBooks()
  func saveBook()
  func updateBook()
  func deleteBook()
}
