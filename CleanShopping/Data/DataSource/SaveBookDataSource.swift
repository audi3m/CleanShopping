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
  func saveBook(book: LocalBookModel) async throws
  func deleteBook(by isbn: String) async throws
}

@MainActor
final class SaveBookDataSourceImpl: SaveBookDataSource {
  
  private let modelContainer: ModelContainer
  private let modelContext: ModelContext
  
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
  
  func fetchBooks() async throws -> [LocalBookModel] {
    do {
      let list = try modelContext.fetch(FetchDescriptor<LocalBookModel>())
      print("Fetch like books")
      return list
    } catch {
      fatalError("Error fetching data\n\(error.localizedDescription)")
    }
  }
  
  func saveBook(book: LocalBookModel) async throws {
    modelContext.insert(book)
    print("Save book: \(book.title)")
  }
  
  func deleteBook(by isbn: String) async throws {
    let books = await getBooks(by: isbn)
    if books.isEmpty {
      print("Fail to fetch books with isbn: \(isbn)")
    } else {
      for book in books {
        modelContext.delete(book)
        print("Deleted book: \(book.title)")
      }
    }
  }
  
  private func getBooks(by isbn: String) async -> [LocalBookModel] {
    let descriptor = FetchDescriptor<LocalBookModel>(predicate: #Predicate { $0.isbn == isbn })
    let books = (try? modelContext.fetch(descriptor)) ?? []
    return books
  }
}
