//
//  Book.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation

struct Book: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let link: String
    let image: String
    let author: String
    let discount: String?
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
}

extension Book {
    var info: String {
        return "저자" + author + " | " + "출판" + publisher + " | " + pubdate
    }
    
    var price: String {
        if let discount {
            return discount + "원"
        } else {
            return ""
        }
    }
}

extension Date {
    func toFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
