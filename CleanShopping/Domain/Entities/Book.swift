//
//  Book.swift
//  CleanShopping
//
//  Created by J Oh on 1/3/25.
//

import Foundation
import Differentiator

struct Book: Identifiable, Hashable, IdentifiableType, Equatable {
  
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
  
  init(title: String,
       link: String,
       image: String,
       author: String,
       discount: String?,
       publisher: String,
       pubdate: String,
       isbn: String,
       description: String) {
    self.title = title
    self.link = link
    self.image = image
    self.author = author
    self.discount = discount
    self.publisher = publisher
    self.pubdate = pubdate
    self.isbn = isbn
    self.description = description
  }
  
  var identity: UUID {
    return self.id
  }
  
}

extension Book {
  var info: String {
    return "저자 " + author + " | " + "출판 " + publisher + " | " + publishDate
  }
  
  var info2: String {
    return "저자 " + author + "\n" + "출판 " + publisher + "\n" + publishDate
  }
  
  var publish: String {
    return publisher + " · " + publishDate
  }
  
  var publishDate: String {
    if pubdate.count == 8, let year = Int(pubdate.prefix(4)),
       let month = Int(pubdate.prefix(6).suffix(2)),
       let day = Int(pubdate.suffix(2)) {
      return String(format: "%04d.%02d.%02d", year, month, day)
    } else if pubdate.count >= 19,
              let year = Int(pubdate.prefix(4)),
              let month = Int(pubdate.prefix(7).suffix(2)),
              let day = Int(pubdate.prefix(10).suffix(2)) {
      return String(format: "%04d.%02d.%02d", year, month, day)
    } else {
      return pubdate
    }
  }
  
  var price: String {
    if let discount {
      return discount + "원"
    } else {
      return ""
    }
  }
}

extension Book {
  static let sample = Book(title: "세컨드 브레인",
                           link: "https://search.daum.net/search?w=bookpage&bookId=6298146&q=%EC%84%B8%EC%BB%A8%EB%93%9C+%EB%B8%8C%EB%A0%88%EC%9D%B8",
                           image: "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6298146%3Ftimestamp%3D20250307153000",
                           author: "티아고 포르테",
                           discount: "16800",
                           publisher: "쌤앤파커스",
                           pubdate: "2023-03-09T00:00:00.000+09:00",
                           isbn: "1165347040 9791165347048",
                           description: "보관하는 별도의 도구를 갖고 있었다는 사실에 착안하여 이를 현대의 기술과 융합했다. 우리의 두뇌가 불필요한 정보로 인해 과부하에 걸리지 않도록 하고 중요한 지식을 효율적으로 활용할 수 있도록 하는 디지털 보관소를 구축한 것이다. ‘세컨드 브레인’이라 명명한 이 시스템은 정보의 수집부터 이를 활용한 창작과 표현에 이르기까지, 모든 과정을 효율적으로 관리하는 기억 장치이자 생산 도구이다. 이 책을 읽은 독자들은 유례없는 정보 과잉 시대의 불안감과 피로함을 극복하고")
}

extension Date {
  func toFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: self)
  }
}
