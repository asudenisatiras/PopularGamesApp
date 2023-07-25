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
        
        let homeViewController = HomeViewController()
        homeViewController.viewModel = HomeViewModel()
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.viewModel = FavoriteViewModel()
        
        viewControllers = [
            createViewController(rootViewController: homeViewController,title: "Games", imageName: "gamecontroller.fill"),
            createViewController(rootViewController: favoriteViewController, title: "Favorites",imageName: "heart.fill")
        ]
       
    }
    
    private func createViewController(rootViewController: UIViewController,title:String, imageName: String) -> UINavigationController {
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(red: 48/255, green: 41/255, blue: 57/255, alpha: 1.0)
        
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.navigationBar.tintColor = .white
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
    
  

  private func customizeTabBar() {

         tabBar.barTintColor = UIColor(red: 255/255, green: 127/255, blue: 80/255, alpha: 1.0)// Updated color
         tabBar.tintColor = UIColor(red: 48/255, green: 41/255, blue: 57/255, alpha: 1.0)
         tabBar.layer.cornerRadius = 12
         tabBar.clipsToBounds = true

         let separatorView = UIView(frame: CGRect(x: tabBar.bounds.width / 2, y: 0, width: 1, height: tabBar.bounds.height))
         separatorView.backgroundColor = UIColor(red: 48/255, green: 41/255, blue: 57/255, alpha: 1.0)
         tabBar.insertSubview(separatorView, at: 0)

      }
  }

