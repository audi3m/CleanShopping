//
//  BaseViewModel.swift
//  CleanShopping
//
//  Created by J Oh on 3/5/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
