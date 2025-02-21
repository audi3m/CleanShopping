//
//  ShoppingTabView.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import UIKit
import SnapKit

final class HomeTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
    setTabItems()
  }
  
}

extension HomeTabBarController {
  private func configureTabBar() {
    tabBar.backgroundColor = .secondarySystemBackground
  }
  
  private func setTabItems() {
    let viewControllers = TabItems.allCases.map { tabItem -> UIViewController in
      let viewController = tabItem.viewController
      viewController.tabBarItem = UITabBarItem(title: tabItem.rawValue, image: tabItem.icon, tag: tabItem.tag)
      return viewController
    }
    
    self.viewControllers = viewControllers
  }
}

extension HomeTabBarController {
  
  private enum TabItems: String, CaseIterable {
    case search = "검색"
    case likes = "좋아요"
    case settings = "설정"
    
    var icon: UIImage? {
      switch self {
      case .search:
        return UIImage(systemName: "magnifyingglass")
      case .likes:
        return UIImage(systemName: "heart.fill")
      case .settings:
        return UIImage(systemName: "gearshape")
      }
    }
    
    var viewController: UIViewController {
      switch self {
      case .search:
        return UINavigationController(rootViewController: SearchViewController(searchBookRepository: SearchBookRepository.shared,
                                                                               viewModel: SearchBookViewModel(networkManager: BookNetworkManager.shared)))
      case .likes:
        return UINavigationController(rootViewController: LikeViewController())
      case .settings:
        return UINavigationController(rootViewController: SettingsViewController())
      }
    }
    
    var tag: Int {
      switch self {
      case .search:
        0
      case .likes:
        1
      case .settings:
        2
      }
    }
  }
}
