//
//  SaveBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SaveBookUseCase {
  func executeFetch() async throws -> [Book]
  func executeSave(book: Book) async throws
//  func executeUpdate() async throws -> [Book]
  func executeDelete(book: Book) async throws
}
