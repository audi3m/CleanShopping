//
//  SaveBookUseCase.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SaveBookUseCase {
  func executeSave(book: Book)
  func executeDelete(book: Book)
}
