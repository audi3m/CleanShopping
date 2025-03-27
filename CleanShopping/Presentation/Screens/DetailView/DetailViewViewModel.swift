//
//  DetailViewViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation

final class DetailViewViewModel {
  private let saveUseCase: SaveBookUseCase
  
  init(saveUseCase: SaveBookUseCase) {
    self.saveUseCase = saveUseCase
  }
  
}

extension DetailViewViewModel: InOutViewModel {
  
  struct Input {
    
  }
  
  struct Output {
    
  }
  
  func transform() {
    
  }
  
}

extension DetailViewViewModel {
  func handleLike() {
    
  }
  
  private func saveBook(book: Book) async throws {
    do {
      try await saveUseCase.executeSave(book: book)
    } catch let error as LocalDataBaseError {
      switch error {
      case .dataSource(let original):
        print("DataSource SAVE Error: \(original)")
      case .repository(let original):
        print("Repository SAVE Error: \(original)")
      case .useCase(let original):
        print("UseCase SAVE Error: \(original)")
      case .unknown:
        print("UNKOWN ERROR in SAVING")
      }
    }
  }
  
  private func deleteBook(book: Book) async throws {
    do {
      try await saveUseCase.executeDelete(book: book)
    } catch let error as LocalDataBaseError {
      switch error {
      case .dataSource(let original):
        print("DataSource DELETE Error: \(original)")
      case .repository(let original):
        print("Repository DELETE Error: \(original)")
      case .useCase(let original):
        print("UseCase DELETE Error: \(original)")
      case .unknown:
        print("UNKOWN ERROR in DELETING")
      }
    }
  }
}
