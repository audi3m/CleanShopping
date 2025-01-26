//
//  APIKey.swift
//  CleanShopping
//
//  Created by J Oh on 1/12/25.
//

import Foundation

enum NaverBookAPI {
    static let baseURL = "https://openapi.naver.com"
    static let idHeader = "X-Naver-Client-Id"
    static let secretHeader = "X-Naver-Client-Secret"
    
    static let id = "i4ticPq9IH6CGvAfDDY2"
    static let secret = "xBRHH5lQ2Z"
}

enum KakaoBookAPI {
    static let baseURL = "https://dapi.kakao.com"
    static let header = "Authorization"
    
    static let auth = "KakaoAK dd4b91061f3197ea075358eed741f0f1"
}

