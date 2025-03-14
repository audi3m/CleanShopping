//
//  SaveBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol SaveBookRepository {
  func fetchBooks() -> [Book]
  func saveBook(book: Book)
//  func updateBook()
  func deleteBook(book: Book)
}
