//
//  BaseViewController.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setHierarchy()
    setLayout()
    setUI()
  }
  
  func setHierarchy() { }
  func setLayout() { }
  func setUI() { }
  
}
