//
//  SearchBookRepository.swift
//  CleanShopping
//
//  Created by J Oh on 1/25/25.
//

import Foundation

final class SearchBookRepository {
    static let shared = SearchBookRepository()
    
    private let networkManager: BookNetworkService
    
    private init(networkManager: BookNetworkService = BookNetworkService.shared) {
        self.networkManager = networkManager
    }
}

extension SearchBookRepository {
    func search() {
        networkManager.searchBooks(model: <#T##Decodable.Type#>,
                                   api: <#T##BookAPI#>,
                                   params: <#T##any BookRequestProtocol#>) { <#Result<Decodable, SearchBookError>#> in
            <#code#>
        }
    }
    
}
