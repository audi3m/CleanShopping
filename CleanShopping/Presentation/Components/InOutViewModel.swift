//
//  InOutViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol InOutViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
