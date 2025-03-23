//
//  DIContainer.swift
//  CleanShopping
//
//  Created by J Oh on 3/14/25.
//

import Foundation
//import Swinject

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

//final class DIContainer2 {
//  
//  static let shared = DIContainer2()
//  
//  private init() {}
//  
//  private var services: [String: Any] = [:]
//  
//  func register<T>(type: T.Type, component: AnyObject) {
//    let key = "\(type)"
//    services[key] = component
//  }
//  
//  func resolve<T>(type: T.Type) -> T {
//    let key = "\(type)"
//    return services[key] as! T
//  }
//  
//  func resolve<T>() -> T {
//    let key = "\(T.self)"
//    return services[key] as! T
//  }
//}
//
//@propertyWrapper
//class DependencyPropertyWrapper<T> {
//    var wrappedValue: T
//    init() {
//        self.wrappedValue = DIContainer2.shared.resolve()
//    }
//}
