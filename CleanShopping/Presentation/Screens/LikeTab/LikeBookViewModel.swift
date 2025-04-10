//
//  LikeBookViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LikeBookViewModel {
  let fetchBooksUseCase: FetchSavedBooksUseCase
  private let disposeBag = DisposeBag()
  
  var input = Input()
  var output = Output()
  
  init(fetchBooksUseCase: FetchSavedBooksUseCase) {
    self.fetchBooksUseCase = fetchBooksUseCase
    
    Task {
      try await initMockDataSource()
    }
    transform()
  }
  
}

extension LikeBookViewModel: InOutViewModel {
  
  struct Input {
    let viewDidLoad = PublishRelay<Void>()
    let tappedBook = PublishRelay<Book>()
  }
  
  struct Output {
    let dataSource = BehaviorRelay<[LikeBookSectionModel]>(value: [])
    let tappedBook = PublishRelay<Book>()
  }
  
  func transform() {
    input.tappedBook
      .bind(with: self) { owner, book in
        owner.output.tappedBook.accept(book)
      }
      .disposed(by: disposeBag)
  }
  
}

extension LikeBookViewModel {
  enum Action {
    case viewDidLoad
    case bookTapped(_ book: Book)
  }
  
  func action(_ action: Action) {
    switch action {
    case .viewDidLoad:
      input.viewDidLoad.accept(())
    case .bookTapped(let book):
      input.tappedBook.accept(book)
    }
  }
}

// Rx
extension LikeBookViewModel {
  private func initDataSource() async throws {
    do {
      let savedBooks = try await fetchBooksUseCase.execute()
      let items = savedBooks.map { LikeBookSectionItem.bodyItem($0) }
      let bodySection = LikeBookSectionModel(header: "Body Section", items: items)
      output.dataSource.accept([bodySection])
    } catch {
      print("Error Fetching books in LikeTab: \(error)")
    }
  }
  
  private func initMockDataSource() async throws {
    let books = Array(repeating: Book.sample, count: 20)
    let items = books.map { LikeBookSectionItem.bodyItem($0) }
    let bodySection = LikeBookSectionModel(header: "Body Section", items: items)
    output.dataSource.accept([bodySection])
  }
  
  private func acceptData(_ section: LikeBookSectionModel) {
    output.dataSource.accept([section])
  }
  
//  private func addItemsToBodySection(newBooks: [Book]) {
//    var currentSections = output.dataSource.value
//    let newItems = newBooks.map { SearchBookSectionItem.bodyItem($0) }
//    guard let bodyIndex = currentSections.firstIndex(where: { $0.header == "Body Section" }) else { return }
//    
//    let updatedItems = currentSections[bodyIndex].items + newItems
//    currentSections[bodyIndex] = SearchBookSectionModel(header: "Body Section", items: updatedItems)
//    
//    output.dataSource.accept(currentSections)
//  }
}

