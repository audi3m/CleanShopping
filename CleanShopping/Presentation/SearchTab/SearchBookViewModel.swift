//
//  SearchBookViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchBookViewModel {
    let disposeBag: DisposeBag
    let networkManager: BookNetworkManager
    
    init(disposeBag: DisposeBag, networkManager: BookNetworkManager) {
        self.disposeBag = disposeBag
        self.networkManager = networkManager
    }
    
    
    
    
    
}

// Search
extension SearchBookViewModel {
    
    func getSearchResults(api: BookAPI, query: String, page: Int, sort: SortOption) async throws -> BookResponse {
        let bookRequest = BookRequest(api: api, query: query, page: page, sort: sort)
        let bookResponse = try await SearchBookRepository.shared.newSearchBook(bookRequest: bookRequest)
        return bookResponse
    }
    
}





// Save
extension SearchBookViewModel {
    func saveBook() {
        
    }
}
