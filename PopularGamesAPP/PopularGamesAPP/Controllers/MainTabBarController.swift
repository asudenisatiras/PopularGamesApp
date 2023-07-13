//
//  MainTabBarController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        customizeTabBar()
    }
}
extension MainTabBarController {
    private func setup(){
        viewControllers = [
            createViewController(rootViewController: HomeViewController(),title: "Games", imageName: "gamecontroller.fill"),
            createViewController(rootViewController: FavoriteViewController(), title: "Favorites",imageName: "heart.fill")
        ]
        
    }
    
    private func createViewController(rootViewController: UIViewController,title:String, imageName: String) -> UINavigationController {
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
    
  

  private func customizeTabBar() {

         tabBar.barTintColor = .white
         tabBar.tintColor = .systemRed
         tabBar.layer.cornerRadius = 12
         tabBar.clipsToBounds = true
         
         
         let backgroundView = UIView(frame: CGRect(x: 12, y: 0, width: tabBar.bounds.width - 24, height: tabBar.bounds.height))
         backgroundView.backgroundColor = .systemGray5
         backgroundView.layer.cornerRadius = 12
         backgroundView.clipsToBounds = true
         
         
         let separatorView = UIView(frame: CGRect(x: backgroundView.bounds.width / 2, y: 0, width: 1, height: backgroundView.bounds.height))
         separatorView.backgroundColor = .separator
         
         
         backgroundView.addSubview(separatorView)
         
         tabBar.insertSubview(backgroundView, at: 0)
      }
  }
