//
//  DIContainer.swift
//  CleanShopping
//
//  Created by J Oh on 3/14/25.
//

import Foundation

@MainActor
final class DIContainer {
  
  private let searchBookDataSource: SearchBookDataSource
  private let saveBookDataSource: SaveBookDataSource
  
  private let searchBookRepository: SearchBookRepository
  private let saveBookRepository: SaveBookRepository
  
  let searchBookUseCase: SearchBookUseCase
  let saveBookUseCase: SaveBookUseCase
  
  static let shared = DIContainer()
  
  private init() {
    let networkManager = BookNetworkManager.shared
    
    self.searchBookDataSource = BookRemoteDataSourceImpl(networkManager: networkManager)
    self.saveBookDataSource = SaveBookDataSourceImpl()
    
    self.searchBookRepository = SearchBookRepositoryImpl(dataSource: searchBookDataSource)
    self.saveBookRepository = SaveBookRepositoryImpl(dataSource: saveBookDataSource)
    
    self.searchBookUseCase = SearchBookUseCaseImpl(repository: searchBookRepository)
    self.saveBookUseCase = SaveBookUseCaseImpl(repository: saveBookRepository)
  }
}
