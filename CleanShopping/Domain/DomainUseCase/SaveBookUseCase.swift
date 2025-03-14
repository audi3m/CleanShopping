//
//  SaveBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SaveBookUseCase {
  func executeSave(book: Book)
}

protocol FetchBooksUseCase {
  func executeFetch() -> [Book]
}

protocol UpdateBooksUseCase {
  func executeUpdate() -> [Book]
}

protocol DeleteBookUseCase {
  func executeDelete(book: Book)
}
