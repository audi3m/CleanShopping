//
//  DetailViewViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

final class DetailViewViewModel {
  private let toggleLikeUseCase: ToggleLikeUseCase
  private let book: Book
  private let disposeBag = DisposeBag()
  
  var input = Input()
  var output = Output()
  
  init(toggleLikeUseCase: ToggleLikeUseCase, book: Book) {
    self.toggleLikeUseCase = toggleLikeUseCase
    self.book = book
    transform()
  }
  
}

extension DetailViewViewModel: InOutViewModel {
  
  struct Input {
    let book = PublishSubject<Void>()
    let saveButtonInput: PublishSubject<Void> = .init()
  }
  
  struct Output {
    let didLoadBook = PublishSubject<Book>()
  }
  
  func transform() {
    input.book
      .bind(with: self) { owner, book in
        
      }
      .disposed(by: disposeBag)
  }
  
}

extension DetailViewViewModel {
  enum Action {
    case viewDidLoad
    case likeTapped(_ book: Book)
  }
  
  func action(_ action: Action) {
    switch action {
    case .viewDidLoad:
      print("View did load")
    case .likeTapped(let book):
      print("like tapped")
    }
  }
}

extension DetailViewViewModel {
  func handleLike(currentLike: Bool, book: Book) async throws {
    do {
      try await toggleLikeUseCase.execute(currentLike: currentLike, book: book)
    } catch {
      throw LocalDataBaseError.viewModel(.unkonwn)
    }
  }
  
  private func toggleLikeBook(currentLike: Bool, book: Book) async throws {
    do {
      try await toggleLikeUseCase.execute(currentLike: currentLike, book: book)
    } catch let error as LocalDataBaseError {
      switch error {
      case .dataSource(let original):
        print("DataSource SAVE Error: \(original)")
      case .repository(let original):
        print("Repository SAVE Error: \(original)")
      case .useCase(let original):
        print("UseCase SAVE Error: \(original)")
      case .viewModel(let original):
        print("ViewModel Handle Error: \(original)")
      case .unknown:
        print("UNKOWN ERROR in SAVING")
      }
    }
  }
}
