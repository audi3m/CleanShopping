//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 1/25/25.
//

import Foundation

final class SearchBookRepository {
    static let shared = SearchBookRepository()
    
    private let networkManager: BookNetworkManager
    
    private init(networkManager: BookNetworkManager = BookNetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension SearchBookRepository {
    func search
    
}
