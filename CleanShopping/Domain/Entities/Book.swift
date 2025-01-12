//
//  Book.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
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
