//
//  Router.swift
//  CleanShopping
//
//  Created by J Oh on 1/16/25.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        if let queryItems { url.append(queryItems: queryItems) }
        var request = try URLRequest(url: url.appendingPathComponent(path), method: method)
        request.headers = headers
        request.httpBody = body
        return request
    }
}

enum Router {
    case naver(param: NaverBookRequestParameter)
    case kakao(param: KakaoBookRequestParameter)
}

extension Router: TargetType {
    var baseURL: String {
        switch self {
        case .naver:
            return BookAPI.naver.url
        case .kakao:
            return BookAPI.kakao.url
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default: .get
        }
    }
    
    var path: String {
        ""
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
                KakaoBookAPI.auth: KakaoBookAPI.auth
            ]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .naver(let param):
            let parameters = [
                URLQueryItem(name: "query", value: param.query),
                URLQueryItem(name: "display", value: param.display),
                URLQueryItem(name: "start", value: param.start),
                URLQueryItem(name: "sort", value: param.sort.rawValue)
            ]
            return parameters
        case .kakao(let param):
            let parameters = [
                URLQueryItem(name: "query", value: param.query),
                URLQueryItem(name: "display", value: param.display),
                URLQueryItem(name: "start", value: param.start),
                URLQueryItem(name: "sort", value: param.sort.rawValue)
            ]
            return parameters
        }
    }
    
    var body: Data? {
        return nil
    }
    
}

