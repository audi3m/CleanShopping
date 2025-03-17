//
//  SaveBookDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation
import SwiftData

protocol SaveBookDataSource {
  func fetchBooks() async -> [LocalBookModel]
  func saveBook(book: LocalBookModel) async
  func deleteBook(by isbn: String) async
}

@MainActor
final class SaveBookDataSourceImpl: SaveBookDataSource {
  
  private let modelContainer: ModelContainer
  private let modelContext: ModelContext
  
  static let shared = SaveBookDataSourceImpl()
  
  init() {
    do {
      self.modelContainer = try ModelContainer(
        for: LocalBookModel.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: false)
      )
      self.modelContext = modelContainer.mainContext
    } catch {
      fatalError("ModelContainer 생성 실패: \(error)")
    }
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
  
  func deleteBook(by isbn: String) {
    if let book = getBook(by: isbn) {
      modelContext.delete(book)
      print("Delete book: \(book.title)")
    } else {
      print("Fail to fetch book of id: \(isbn)")
    }
  }
  
  private func getBook(by isbn: String) -> LocalBookModel? {
    let descriptor = FetchDescriptor<LocalBookModel>(predicate: #Predicate { $0.isbn == isbn })
    return try? modelContext.fetch(descriptor).first
  }
}
