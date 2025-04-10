//
//  SaveBookDataSource.swift
//  CleanShopping
//
//  Created by J Oh on 3/3/25.
//

import Foundation
import SwiftData

protocol SaveBookDataSource {
  func fetchBooks() async throws -> [LocalBookModel]
  func saveBook(book: LocalBookModel) async
  func deleteBook(isbn: String) async throws
}

@MainActor
final class SaveBookDataSourceImpl: SaveBookDataSource {
  
  private let modelContainer: ModelContainer
  private let modelContext: ModelContext
  
  init() {
    do {
      self.modelContainer = try ModelContainer(for: LocalBookModel.self)
      self.modelContext = modelContainer.mainContext
    } catch {
      fatalError("ModelContainer 생성 실패: \(error)")
    }
  }
  
  func fetchBooks() async throws -> [LocalBookModel] {
    do {
      let list = try modelContext.fetch(FetchDescriptor<LocalBookModel>())
      print("Fetch like books: \(list.count)")
      return list
    } catch {
      throw LocalDataBaseError.dataSource(.fetch(original: error))
    }
  }
  
  func saveBook(book: LocalBookModel) async {
    modelContext.insert(book)
    print("Save book: \(book.title)")
  }
  
  func deleteBook(isbn: String) async throws {
    do {
      let books = try await getBooksByISBN(isbn: isbn)
      for book in books {
        modelContext.delete(book)
        print("Deleted book: \(book.title)")
      }
    } catch {
      throw LocalDataBaseError.dataSource(.delete(original: error))
    }
  }
  
  private func getBooksByISBN(isbn: String) async throws -> [LocalBookModel] {
    do {
      let descriptor = FetchDescriptor<LocalBookModel>(predicate: #Predicate { $0.isbn == isbn })
      return try modelContext.fetch(descriptor)
    } catch {
      throw LocalDataBaseError.dataSource(.fetch(original: error))
    }
  }
}
