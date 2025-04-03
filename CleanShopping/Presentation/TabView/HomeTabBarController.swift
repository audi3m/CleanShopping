//
//  HomeTabBarController.swift
//  CleanShopping
//
//  Created by J Oh on 1/18/25.
//

import UIKit
import SnapKit

final class HomeTabBarController: UITabBarController {
  
  private let container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
      let viewController = tabItem.setViewController(with: container) // container 전달
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
    
    @MainActor
    func setViewController(with container: DIContainer) -> UIViewController {
      switch self {
      case .search:
        let viewModel = SearchBookViewModel(searchBookUseCase: container.searchBookUseCase,
                                             saveBookUseCase: container.saveBookUseCase)
        return UINavigationController(
          rootViewController: SearchBookViewController(viewModel: viewModel)
        )
      case .likes:
        let viewModel = LikeBookViewModel(saveBookUseCase: container.saveBookUseCase)
        return UINavigationController(rootViewController: LikeBookViewController(viewModel: viewModel))
      case .settings:
        let viewModel = DetailViewViewModel(saveUseCase: container.saveBookUseCase)
        return UINavigationController(rootViewController: DetailViewController(viewModel: viewModel))
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
