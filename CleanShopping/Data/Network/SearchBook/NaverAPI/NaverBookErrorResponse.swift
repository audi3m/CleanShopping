//
//  NaverBookErrorResponse.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import Foundation

struct NaverBookErrorResponse: Decodable {
    let errorMessage: String
    let errorCode: String
}
