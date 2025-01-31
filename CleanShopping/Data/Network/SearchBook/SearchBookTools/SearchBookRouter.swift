//
//  SearchBookRouter.swift
//  CleanShopping
//
//  Created by J Oh on 1/16/25.
//

import Foundation
import Alamofire

// 네트워크 Request 만들 때 필요한 속성들 케이스로 나누어 정리 해놓은 것
enum SearchBookRouter {
    case naver(param: NaverBookRequestParameters)
    case kakao(param: KakaoBookRequestParameters)
}

extension SearchBookRouter: TargetType {
    var baseURL: String {
        switch self {
        case .naver:
            return NaverBookAPI.baseURL
        case .kakao:
            return KakaoBookAPI.baseURL
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .naver:
            return .get
        case .kakao:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .naver:
            return "/v1/search/book.json"
        case .kakao:
            return "/v3/search/book"
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        switch self {
        case .naver:
            return [
                NaverBookAPI.idHeader: NaverBookAPI.id,
                NaverBookAPI.secretHeader: NaverBookAPI.secret
            ]
        case .kakao:
            return [
                KakaoBookAPI.header: KakaoBookAPI.auth
            ]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .naver(let param):
            let parameters = [
                URLQueryItem(name: "query", value: param.query),
                URLQueryItem(name: "display", value: "\(param.display)"),
                URLQueryItem(name: "start", value: "\(param.start)"),
                URLQueryItem(name: "sort", value: param.sort.asString)
            ]
            return parameters
        case .kakao(let param):
            let parameters = [
                URLQueryItem(name: "query", value: param.query),
                URLQueryItem(name: "sort", value: param.sort.asString),
                URLQueryItem(name: "page", value: "\(param.page)"),
                URLQueryItem(name: "size", value: "\(param.size)"),
//                URLQueryItem(name: "target", value: param.target.rawValue)
            ]
            return parameters
        }
    }
    
    var body: Data? {
        switch self {
        case .naver:
            return nil
        case .kakao:
            return nil
        }
    }
    
}
