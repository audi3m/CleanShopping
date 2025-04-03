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
  private let saveBookUseCase: SaveBookUseCase
  private let disposeBag = DisposeBag()
  
  var input = Input()
  var output = Output()
  
  init(saveBookUseCase: SaveBookUseCase) {
    self.saveBookUseCase = saveBookUseCase
    
    Task {
      try await initMockDataSource()
    }
    transform()
  }
  
}

extension LikeBookViewModel: InOutViewModel {
  
  struct Input {
    var tappedBook = PublishRelay<Book>()
  }
  
  struct Output {
    let dataSource = BehaviorRelay<[LikeBookSectionModel]>(value: [])
  }
  
  func transform() {
    
  }
  
}

// Rx
extension LikeBookViewModel {
  private func initDataSource() async throws {
    do {
      let savedBooks = try await saveBookUseCase.executeFetch()
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

