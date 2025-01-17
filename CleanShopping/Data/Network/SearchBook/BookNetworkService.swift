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
    
    func searhNaverBooks(params: NaverBookRequestParameters,
                         handler: @escaping (Result<NaverBookResponseDTO, Error>) -> Void) {
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
                         handler: @escaping (Result<KakaoBookResponseDTO, Error>) -> Void) {
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
