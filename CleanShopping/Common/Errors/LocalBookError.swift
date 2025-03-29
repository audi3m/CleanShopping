//
//  LocalBookError.swift
//  CleanShopping
//
//  Created by J Oh on 3/27/25.
//

import Foundation

enum NetworkBaseError: Error {
  
}

enum LocalDataBaseError: Error {
  case dataSource(OperationError)
  case repository(OperationError)
  case useCase(OperationError)
  case unknown
  
  enum OperationError: Error {
    case fetch(original: Error)
    case save(original: Error)
    case delete(original: Error)
  }
  
}
