//
//  BookNetworkService.swift
//  CleanShopping
//
//  Created by J Oh on 1/15/25.
//

import Foundation
import Alamofire

enum BookAPI {
    case naver
    case kakao
    
    var decodingType: Decodable.Type {
        switch self {
        case .naver:
            return NaverBookResponseDTO.self
        case .kakao:
            return KakaoBookResponseDTO.self
        }
    }
}

final class BookNetworkService {
    
    static let shared = BookNetworkService()
    private init() { }
    
    func searchBooks(bookRequest: BookRequest,
                     handler: @escaping (Result<BookResponseProtocol, SearchBookError>) -> Void) {
        let request = makeRequest(bookRequest: bookRequest)
        AF.request(request)
            .validate(statusCode: 200...299)
            .responseDecodable(of: bookRequest.api.decodingType) { response in
                switch response.result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(.networkError))
                }
            }
    }
    
    func searhNaverBooks(params: NaverBookRequestParameters,
                         handler: @escaping (Result<NaverBookResponseDTO, SearchBookError>) -> Void) {
        do {
            let request = try SearchBookRouter.naver(param: params).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: NaverBookResponseDTO.self) { response in
                    switch response.result {
                    case .success(let value):
                        handler(.success(value))
                    case .failure:
                        handler(.failure(.networkError))
                    }
                }
        } catch {
            print(error)
        }
    }
    
    func searhKakaoBooks(params: KakaoBookRequestParameters,
                         handler: @escaping (Result<KakaoBookResponseDTO, SearchBookError>) -> Void) {
        do {
            let request = try SearchBookRouter.kakao(param: params).asURLRequest()
            AF.request(request)
                .validate(statusCode: 200...299)
                .responseDecodable(of: KakaoBookResponseDTO.self) { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        print(error)
                    }
                }
        } catch {
            print(error)
        }
    }
}

extension BookNetworkService {
    private func makeRequest(bookRequest: BookRequest) -> URLRequest {
        do {
            let params = bookRequest.toDTO()
            switch bookRequest.api {
            case .naver:
                return try SearchBookRouter.naver(param: params as! NaverBookRequestParameters).asURLRequest()
            case .kakao:
                return try SearchBookRouter.kakao(param: params as! KakaoBookRequestParameters).asURLRequest()
            }
        } catch {
            print("UrlRequest Error : \(error)")
            return URLRequest(url: URL(string: "")!)
        }
    }
    
}

enum SearchBookError: Error {
    case networkError
}

