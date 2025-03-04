//
//  SaveBookUseCaseProtocol.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

protocol SaveBookUseCaseProtocol {
  func executeSave(book: Book)
  func executeDelete(book: Book)
}
