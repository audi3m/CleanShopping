//
//  LikeBooksManager.swift
//  CleanShopping
//
//  Created by J Oh on 4/18/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LikeBooksManager {
  static let shared = LikeBooksManager()
  private init() {}
  
  let likeBooks = BehaviorRelay<[Book]>(value: [])
  let likeISBNSet = BehaviorRelay<Set<String>>(value: [])
  
  
  
  
  
}
