//
//  DetailViewViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

final class DetailViewViewModel {
  private let saveUseCase: SaveBookUseCase
  private let book: Book
  private let disposeBag = DisposeBag()
  
  var input = Input()
  var output = Output()
  
  init(saveUseCase: SaveBookUseCase, book: Book) {
    self.saveUseCase = saveUseCase
    self.book = book
    transform()
  }
  
}

extension DetailViewViewModel: InOutViewModel {
  
  struct Input {
    let didLoadInput = PublishSubject<Void>()
    let saveButtonInput: PublishSubject<Void> = .init()
  }
  
  struct Output {
    let didLoadDetailViewOutput = PublishSubject<Book>()
  }
  
  func transform() {
    input.didLoadInput
      .bind(with: self) { viewModel, _ in
        viewModel.output.didLoadDetailViewOutput.onNext(viewModel.book)
      }
      .disposed(by: disposeBag)
  }
  
}

extension DetailViewViewModel {
  enum Action {
    case viewDidLoad
//    case likeTapped(_ book: Book)
  }
  
  func action(_ action: Action) {
    switch action {
    case .viewDidLoad:
      input.didLoadInput.
//    case .likeTapped(let book):
//      input.tappedBook.accept(book)
    }
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
