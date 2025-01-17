//
//  BookNetworkService.swift
//  CleanShopping
//
//  Created by J Oh on 1/15/25.
//

import Foundation
import Alamofire

final class BookNetworkService {
    
    static let shared = BookNetworkService()
    private init() { }
    
    func searhBooks(api: SearchBookRouter, handler: @escaping (Result<BookResponse, Error>) -> Void) {
        let request = try SearchBookRo
        AF.request(request)
            .validate(statusCode: 200...299)
            .responseDecodable(of: BookResponse.self) { response in
                
            }
        
    }
    
    
    
    
}
