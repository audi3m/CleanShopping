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
    private let disposeBag: DisposeBag
    
    private let networkManager: BookNetworkManager
    private let searchPage = BehaviorRelay<Int>(value: 1)
    
    var input = Input()
    var output = Output()
    
    
    init(networkManager: BookNetworkManager) {
        self.disposeBag = DisposeBag()
        self.networkManager = networkManager
    }
    
}

extension SearchBookViewModel {
    struct Input {
        var viewDidLoad = PublishRelay<Void>()
        var searchButtonClicked = PublishRelay<Void>()
        var searchAPI = PublishRelay<BookAPI>()
        var searchQuery = PublishRelay<String>()
        var searchPage = PublishRelay<Int>()
        var searchSortOption = PublishRelay<SortOption>()
        var loadNextPage = PublishRelay<Void>()
        var tappedBook = PublishRelay<Book>()
    }
    
    struct Output {
        var movieCellTapData = PublishRelay<Book>()
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
