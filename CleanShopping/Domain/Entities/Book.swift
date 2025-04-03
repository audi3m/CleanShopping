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
  static let sample = Book(title: "일론 머스크",
                           link: "https://search.shopping.naver.com/book/catalog/42189304618",
                           image: "https://shopping-phinf.pstatic.net/main_4218930/42189304618.20230926084740.jpg",
                           author: "월터 아이작슨",
                           discount: "16800",
                           publisher: "21세기북스",
                           pubdate: "20230913",
                           isbn: "9791171170418",
                           description: "미래는 꿈꾸는 것이 아니라 만드는 것,\n그가 상상하면 모두 현실이 된다!”\n\n천재인가 몽상가인가, 영웅인가 사기꾼인가? \n수많은 논란 속에서도 1%의 가능성에 모든 걸 걸며 \n인류의 미래를 바꾸는 이 시대 최고의 혁신가, 일론 머스크의 모든 것!\n\n스티브 잡스의 유일한 공식 전기를 쓴 저자 월터 아이작슨이 집필한 2023년도 최고의 화제작 《일론 머스크》가 21세기북스에서 출간됐다. ‘일론 머스크’ 하면 여러분은 어떤 이미지가 떠오르는가? 세계 1위 부자, 미래 산업의 선두주자, 괴짜, 몽상가, 사기꾼, 천재, 영웅, 혁신가, 허풍쟁이, 냉혈한, 관종…. 한 사람이 이렇게 극과 극의 별명으로 불리는 경우가 또 있을까 싶을 정도로 일론 머스크를 향한 대중과 언론의 평가는 극단적으로 갈린다. 누군가는 그를 이 시대 최고의 혁신가이자 인류를 구할 영웅이라며 존경을 표하는 반면, 누군가는 그를 충동적인 트윗과 말실수로 하룻밤에도 수조 원의 자산 가치를 날려버리는 문제적 기업가라며 비난한다. 도전하는 사업마다 놀라운 혁신으로 업계의 판도를 뒤집는 기업가지만, 그 이면에는 공감 능력 제로의 독재자라는 불명예스러운 평가도 존재한다. 하지만 그는 쿨하게 인정한다. 자신이 정상적인 사람은 아니라는 걸. \n\n“혹시 저 때문에 감정이 상한 사람이 있다면, 그저 이렇게 말하고 싶네요. \n저는 전기차를 재창조했고, 지금은 사람들을 로켓선에 태워 화성으로 보내려 하고 있습니다. \n그런 제가 차분하고 정상적인 친구일 거라고 생각하셨나요?”\n- 일론 머스크, 〈새터데이나이트 라이브(SNL)〉에 출연해서\n\n이 공식 전기의 집필을 위해 일론 머스크를 2년간 그림자처럼 따라다니고, 주변인들을 인터뷰하며 다양한 측면으로 그를 분석한 아이작슨은 대중이 그에 대해 알고 있는 건 피상적인 면에 불과하다고 강조한다. “악마 모드와 열정을 빼놓고는 일론 머스크를 논할 수 없”는 건 사실이지만, 그가 그렇게 된 데에는 외상후스트레스장애처럼 정서적으로 큰 상처를 받아 감정을 차단하게 된 어린 시절의 영향이 있었다는 거다. 또한 그런 냉정한 성향이 한편으로는 장점으로 발휘되어 극도의 리스크를 즐기며 모두가 불가능하다고 하는 일들을 벌여나갈 수 있었던 거라고도 말한다. 꽤 오랜 시간 일론 머스크와 깊은 시간을 보냈기 때문에 그에 대한 깊은 이해력을 갖게 되었다고 말하는 아이작슨은 “과연 그가 괴팍하지 않았다면 우리를 전기차의 미래로, 그리고 화성으로 인도하는 사람이 될 수 있었을까?”라며 독자들에게 질문을 던진다. 이 책에 담긴 일론 머스크의 솔직한 인터뷰를 통해 불가능에 도전하면서도 절대 포기하지 않는 모험가로서의 면모뿐만 아니라 그동안 공개하지 않았던 놀랍도록 사적인 이야기를 들을 수 있다. 이 책을 읽지 않고서는 인간 일론 머스크뿐만 아니라 테슬라도, 스페이스X도, 인공지능도, 화성 탐사 계획도, 그리고 앞으로 그가 우리 눈앞에 가져올 미래에 대해서도 감히 안다고 말해선 안 된다.")
}

extension Date {
  func toFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: self)
  }
}
