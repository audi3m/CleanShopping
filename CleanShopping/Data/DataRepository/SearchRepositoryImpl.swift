//
//  SearchRepositoryImpl.swift
//  CleanShopping
//
//  Created by J Oh on 2/27/25.
//

import Foundation
import RxSwift

final class SearchRepositoryImpl: SearchBookRepository {
  
  private let dataSource: BookRemoteDataSource
  
  init(dataSource: BookRemoteDataSource) {
    self.dataSource = dataSource
  }
  
  func searchBook() {
    dataSource.searchBooks()
  }
  
  func searchBookSingle() {
    dataSource.searchBooks()
  }
  
  func searchBookAsync() {
    dataSource.searchBooks()
  }
  
}
