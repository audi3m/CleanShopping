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
    let networkManager: BookNetworkManager
    
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
        var searchApi = PublishRelay<BookAPI>()
        var searchQuery = PublishRelay<String>()
        var searchPage = PublishRelay<Int>()
        var searchSortOption = PublishRelay<SortOption>()
        var loadNextPage = PublishRelay<Void>()
        var tappedBook = PublishRelay<Book>()
    }
    
    struct Output {
        var searchedBooks = BehaviorRelay<[Book]>(value: [])
        var movieCellTapData = PublishRelay<Book>()
    }
}

// Search
extension SearchBookViewModel {
    
    
}





// Save
extension SearchBookViewModel {
    func saveBook() {
        
    }
}
