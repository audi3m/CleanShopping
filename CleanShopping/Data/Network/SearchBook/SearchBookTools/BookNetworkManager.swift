//
//  BookNetworkManager.swift
//  CleanShopping
//
//  Created by J Oh on 1/15/25.
//

import Foundation
import Alamofire

final class BookNetworkManager {
    
    static let shared = BookNetworkManager()
    private init() { }
    
    func request<T: Decodable>(target: SearchBookRouter,
                               of type: T.Type,
                               handler: @escaping (Result<T, Error>) -> Void) {
        
        
        
            
        }
    
}

//extension BookNetworkManager {
//    
//    func searhNaverBooks(params: NaverBookRequestParameters,
//                         handler: @escaping (Result<NaverBookResponseDTO, NaverBookResponseError>) -> Void) {
//        do {
//            let request = try SearchBookRouter.naver(param: params).asURLRequest()
//            AF.request(request)
//                .validate(statusCode: 200...299)
//                .responseDecodable(of: NaverBookResponseDTO.self) { response in
//                    switch response.result {
//                    case .success(let value):
//                        handler(.success(value))
//                    case .failure:
//                        handler(.failure(.responseError))
//                    }
//                }
//        } catch {
//            print(error)
//        }
//    }
//    
//    func searhKakaoBooks(params: KakaoBookRequestParameters,
//                         handler: @escaping (Result<KakaoBookResponseDTO, KakaoBookResponseError>) -> Void) {
//        do {
//            let request = try SearchBookRouter.kakao(param: params).asURLRequest()
//            AF.request(request)
//                .validate(statusCode: 200...299)
//                .responseDecodable(of: KakaoBookResponseDTO.self) { response in
//                    switch response.result {
//                    case .success(let value):
//                        handler(.success(value))
//                    case .failure(let error):
//                        handler(.failure(.responseError))
//                    }
//                }
//        } catch {
//            print(error)
//        }
//    }
//}
