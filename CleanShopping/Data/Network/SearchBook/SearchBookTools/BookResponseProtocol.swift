//
//  ResponseProtocol.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

protocol BookResponseProtocol: Decodable {
  func toDomain() -> BookResponse
}

protocol BookDTOProtocol {
  func toDomain() -> Book
}
