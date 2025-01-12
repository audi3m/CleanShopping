//
//  NaverResponse.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct NaverBookResponseDTO: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NaverBookDTO]
}

struct NaverBookDTO: Decodable {
    let title: String
    let link: String
    let image: String
    let author: String
    let discount: String
    let publisher: String
    let pubdate: Date
    let isbn: Int
    let description: String
}
