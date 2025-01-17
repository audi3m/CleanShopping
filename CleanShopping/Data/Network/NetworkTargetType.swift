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
