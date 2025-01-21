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
    
    func searchBooks<T: Decodable>(model: T.Type,
                                   api: BookAPI,
                                   params: BookRequestProtocol,
                                   handler: @escaping (Result<T, Error>) -> Void) {
        let request = makeRequest(apiType: api, params: params)
        AF.request(request)
            .validate(statusCode: 200...299)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
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
                        print(value)
                    case .failure(let error):
                        print(error)
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
    private func makeRequest(apiType: BookAPI,
                             params: BookRequestProtocol) -> URLRequest {
        do {
            switch apiType {
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
    
}

