//
//  SaveBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SaveBookUseCase {
  func executeSave(book: Book) async
}

protocol FetchBooksUseCase {
  func executeFetch() async -> [Book]
}

protocol UpdateBooksUseCase {
  func executeUpdate() async -> [Book]
}

protocol DeleteBookUseCase {
  func executeDelete(book: Book) async
}
