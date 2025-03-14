//
//  SaveBookDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation
import SwiftData

protocol SaveBookDataSource {
  func fetchBooks() -> [LocalBookModel]
  func saveBook(book: LocalBookModel)
  func deleteBook(by id: UUID)
}

final class BookLocalDataSourceImpl: SaveBookDataSource {
  
  private let modelContainer: ModelContainer
  private let modelContext: ModelContext
  
  @MainActor
  static let shared = BookLocalDataSourceImpl()
  
  @MainActor
  private init() {
    self.modelContainer = try! ModelContainer(
      for: LocalBookModel.self,
      configurations: ModelConfiguration(isStoredInMemoryOnly: false)
    )
    self.modelContext = modelContainer.mainContext
  }
  
  func fetchBooks() -> [LocalBookModel] {
    do {
      let list = try modelContext.fetch(FetchDescriptor<LocalBookModel>())
      print("Fetch like books")
      return list
    } catch {
      fatalError("Error fetching data\n\(error.localizedDescription)")
    }
  }
  
  func saveBook(book: LocalBookModel) {
    modelContext.insert(book)
    print("Save new book: \(book.title)")
  }
  
  func deleteBook(by id: UUID) {
    if let book = getBook(by: id) {
      modelContext.delete(book)
      print("Delete book: \(book.title)")
    } else {
      print("Fail to fetch book of id: \(id)")
    }
  }
  
  private func getBook(by id: UUID) -> LocalBookModel? {
    let descriptor = FetchDescriptor<LocalBookModel>(predicate: #Predicate { $0.id == id })
    return try? modelContext.fetch(descriptor).first
  }
}
