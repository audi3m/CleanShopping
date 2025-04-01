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
      try await initDataSource()
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
      let bodySection = LikeBookSectionModel(
        header: "Body Section",
        items: items
      )
      output.dataSource.accept([bodySection])
    } catch {
      print("Error Fetching books in LikeTab: \(error)")
    }
  }
}
