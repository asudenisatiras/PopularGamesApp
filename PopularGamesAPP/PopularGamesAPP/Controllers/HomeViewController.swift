//
//  HomeViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

//import UIKit
//import GamesAPI // data models are defined in the API
//
//class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
//
//    var pageViewController: UIPageViewController!
//    var pages: [UIViewController] = []
//    var pageControl: UIPageControl!
//    var collectionView: UICollectionView!
//
//    var viewModel: HomeViewModelProtocol! {
//        didSet {
//            viewModel.delegate = self
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        layout()
//        viewModel.downloadGames(nil)
//        setupp()
//    }
//
////    private func createPageViewController(with game: Games) -> UIViewController {
////        let newViewController = PageViewController()
////
////        newViewController.gameName = game.name
////
////        if let backgroundImageURLString = game.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
////            newViewController.gameImage = UIImage(data: imageData)
////        }
////
////        return newViewController
////    }
//    private func createPageViewController(with game: Games) -> UIViewController {
//        let newViewController = PageViewController()
//        newViewController.gameName = game.name
//
//        DispatchQueue.global().async {
//            if let backgroundImageURLString = game.backgroundImage,
//               let backgroundImageURL = URL(string: backgroundImageURLString),
//               let imageData = try? Data(contentsOf: backgroundImageURL) {
//                DispatchQueue.main.async {
//                    newViewController.gameImage = UIImage(data: imageData)
//                }
//            }
//        }
//
//        return newViewController
//    }
//
//}
//
//extension HomeViewController {
//    private func setup(){
//
//        view.backgroundColor = .white
//
//                pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//                pageViewController.view.layer.cornerRadius = 12
//                pageViewController.dataSource = self
//                pageViewController.delegate = self
//
//                addChild(pageViewController)
//                view.addSubview(pageViewController.view)
//
//                pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//               pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//               pageViewController.view.widthAnchor.constraint(equalToConstant: 100),
//               pageViewController.view.heightAnchor.constraint(equalToConstant: 220),
//               pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//               pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
//           ])
//
//                pageControl = UIPageControl()
//                pageControl.translatesAutoresizingMaskIntoConstraints = false
//                pageControl.currentPageIndicatorTintColor = .systemRed
//                pageControl.pageIndicatorTintColor = .gray
//                pageControl.numberOfPages = pages.count
//                view.addSubview(pageControl)
//
//                NSLayoutConstraint.activate([
//                    pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    pageControl.bottomAnchor.constraint(equalTo: pageViewController.bottomLayoutGuide.bottomAnchor, constant: 22)
//                ])
//
//          collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
//          let flowLayout = UICollectionViewFlowLayout()
//          flowLayout.scrollDirection = .vertical
//          collectionView.register(GamesListCollectionViewCell.self,
//                                  forCellWithReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier)
//          collectionView.delegate = self
//          collectionView.dataSource = self
//          view.addSubview(collectionView)
//
//
//          collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//          collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
//          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//                pageViewController.didMove(toParent: self)
//
//            }
//
//    private func layout() {
//            let searchController = UISearchController(searchResultsController: nil)
//            navigationItem.searchController = searchController
//            navigationItem.hidesSearchBarWhenScrolling = false
//            searchController.searchBar.delegate = self
//        }
//    }
//
//extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
//                    return nil
//                }
//                return pages[currentIndex - 1]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
//                   return nil
//               }
//               return pages[currentIndex + 1]
//    }
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//          if completed, let currentViewController = pageViewController.viewControllers?.first, let currentIndex = pages.firstIndex(of: currentViewController) {
//              pageControl.currentPage = currentIndex
//          }
//      }
//    private func setupp() {
//
//           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pageViewControllerTapped))
//           pageViewController.view.addGestureRecognizer(tapGestureRecognizer)
//           tapGestureRecognizer.delegate = self
//       }
//
//
//    @objc private func pageViewControllerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
//
//        if let currentViewController = pageViewController.viewControllers?.first as? PageViewController {
//            if let currentIndex = pages.firstIndex(of: currentViewController) {
//                viewModel.fetchGameDetails(
//                    index: currentIndex, isPageControl: true
//                )
//            }
//        }
//    }
//
//
//}
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         return viewModel.gamesCount
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier, for: indexPath) as! GamesListCollectionViewCell
//        cell.backgroundColor = .systemGray4
//
//        let games = viewModel.getGame(index: indexPath.row)//self.games[indexPath.row]
//
//        let viewModel = GamesListCellViewModel(game: games)
//                cell.configure(with: viewModel)
//         return cell
//     }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.fetchGameDetails(index: indexPath.row, isPageControl: false)
//    }
//
//}
//extension HomeViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (collectionView.frame.width - 48)
//           let height: CGFloat = 130
//           return CGSize(width: width, height: height)
//       }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
//    }
//
//}
//
//extension HomeViewController {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.fetchGames(searchText)
//    }
//
////    private func printGameDetails(_ game: Games, _ videoGame: VideoGames) {
////        print("Game ID: \(game.id)")
////        print("Game Name: \(game.name)")
////        print("Released Date: \(game.released ?? "")")
////        print("Metacritic Score: \(game.metacritic ?? 0)")
////        print("Background Image URL: \(game.backgroundImage ?? "")")
////        print("Description: \(videoGame.description ?? "")")
////
////    }
//}
//
//extension HomeViewController: HomeViewModelDelegate {
//
////    func detailDownloadFinished(
////        selectedGame: Games,
////        gameDetails: VideoGames
////    ) {
////        DispatchQueue.main.async {
////            let detailsViewController = DetailsViewController()
////            detailsViewController.gameName = selectedGame.name
////            detailsViewController.releasedDate = selectedGame.released
////            detailsViewController.metacriticR = selectedGame.metacritic.map { String($0) }
////            detailsViewController.detailsL = gameDetails.description
////            detailsViewController.gameid = selectedGame.id
////            if let backgroundImageURLString = selectedGame.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
////                detailsViewController.gameImage = UIImage(data: imageData)
////            }
////            detailsViewController.hidesBottomBarWhenPushed = true
////            self.navigationController?.pushViewController(detailsViewController, animated: true)
////        }
////    }
//    func detailDownloadFinished(
//        selectedGame: Games,
//        gameDetails: VideoGames
//    ) {
//        DispatchQueue.main.async {
//            let detailsViewController = DetailsViewController()
//            detailsViewController.gameName = selectedGame.name
//            detailsViewController.releasedDate = selectedGame.released
//            detailsViewController.metacriticR = selectedGame.metacritic.map { String($0) }
//            detailsViewController.detailsL = gameDetails.description
//            detailsViewController.gameid = selectedGame.id
//
//
//            DispatchQueue.global().async {
//                if let backgroundImageURLString = selectedGame.backgroundImage,
//                   let backgroundImageURL = URL(string: backgroundImageURLString),
//                   let imageData = try? Data(contentsOf: backgroundImageURL) {
//                    DispatchQueue.main.async {
//                        detailsViewController.gameImage = UIImage(data: imageData)
//                        detailsViewController.hidesBottomBarWhenPushed = true
//                        self.navigationController?.pushViewController(detailsViewController, animated: true)
//                    }
//                }
//            }
//        }
//    }
//
//    func gamesListDownloadFinished() {
//        let firstThreeGames = viewModel.getFirstThreeGames()
//        self.pages = firstThreeGames.map { self.createPageViewController(with: $0) }
//        self.pageControl.numberOfPages = self.pages.count
//
//        collectionView.reloadData()
//        self.pageViewController.setViewControllers([self.pages.first].compactMap { $0 }, direction: .forward, animated: true, completion: nil)
//    }
//}
import UIKit
import GamesAPI // data models are defined in the API

extension HomeViewController {
    fileprivate enum Constants {
        static let pageControllerHeight: CGFloat = 220
        static let pageControlHeight: CGFloat = 25
    }
}

class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    var pageViewController: UIPageViewController!
    var pages: [UIViewController] = []
    var pageControl: UIPageControl!
    var collectionView: UICollectionView!
    
    var pageControllerHeightAnchor: NSLayoutConstraint?
    var pageControlHeightAnchor: NSLayoutConstraint?
    
    var collectionViewTopToPageControlConstraint: NSLayoutConstraint!
    private lazy var homeStackView : UIStackView = {
        homeStackView = UIStackView(
            arrangedSubviews: [
                pageViewController.view,
                pageControl,
                collectionView
            ]
        )
        homeStackView.axis = .vertical
        return homeStackView
    }()
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var isSearchActive = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        viewModel.downloadGames(nil)
        setupp()
    }
   
    private func createPageViewController(with viewModel: PageViewModel) -> UIViewController {
           let newViewController = PageViewController()
           newViewController.gameName = viewModel.gameName
        
           viewModel.loadGameImage { imageData in
               if let imageData = imageData {
                   newViewController.gameImage = UIImage(data: imageData)
               } else {
                   // Set placeholder image or loading indicator
                   newViewController.gameImage = UIImage(named: "loading")
               }
           }

           return newViewController
       }

}

extension HomeViewController {
    private func setup(){
        view.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)


     
       /* homeStackView.addArrangedSubview(pageViewController.view)
        homeStackView.addArrangedSubview(pageControl)
        homeStackView.addArrangedSubview(collectionView)*/
        
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = pages.count
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.register(GamesListCollectionViewCell.self,
                                forCellWithReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.layer.cornerRadius = 12
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        setupPageControlHeight()
        
        collectionView.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)

       
        view.addSubview(homeStackView)
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        pageViewController.didMove(toParent: self)
        

    }
    
    private func setupPageControlHeight() {
        pageControllerHeightAnchor = pageViewController.view.heightAnchor.constraint(
            equalToConstant: Constants.pageControllerHeight)
        pageControlHeightAnchor = pageControl.heightAnchor.constraint(
            equalToConstant: Constants.pageControlHeight)
        
        pageControllerHeightAnchor?.isActive = true
        pageControlHeightAnchor?.isActive = true
    }

    private func layout() {
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.delegate = self
        let textField = searchController.searchBar.searchTextField
             let attributes: [NSAttributedString.Key: Any] = [
                 .foregroundColor: UIColor.white,
                 .font: UIFont.systemFont(ofSize: 16)
             ]
             textField.attributedPlaceholder = NSAttributedString(string: "Find Popular Games...", attributes: attributes)
        if let glassIconView = textField.leftView as? UIImageView {
                    glassIconView.tintColor = .white
                }
         }          }
            
      
    

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
                    return nil
                }
                return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
                   return nil
               }
               return pages[currentIndex + 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          if completed, let currentViewController = pageViewController.viewControllers?.first, let currentIndex = pages.firstIndex(of: currentViewController) {
              pageControl.currentPage = currentIndex
          }
      }
    private func setupp() {

           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pageViewControllerTapped))
           pageViewController.view.addGestureRecognizer(tapGestureRecognizer)
           tapGestureRecognizer.delegate = self
       }


    @objc private func pageViewControllerTapped(_ gestureRecognizer: UITapGestureRecognizer) {

        if let currentViewController = pageViewController.viewControllers?.first as? PageViewController {
            if let currentIndex = pages.firstIndex(of: currentViewController) {
                viewModel.fetchGameDetails(
                    index: currentIndex, isPageControl: true
                )
            }
        }
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.gamesCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier, for: indexPath) as! GamesListCollectionViewCell
        cell.backgroundColor = UIColor(red: 31/255, green: 24/255, blue: 40/255, alpha: 1.0)

        let games = viewModel.getGame(index: indexPath.row)//self.games[indexPath.row]

        let viewModel = GamesListCellViewModel(game: games)
                cell.configure(with: viewModel)
         return cell
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.fetchGameDetails(index: indexPath.row, isPageControl: false)
    }

}
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - 48)
           let height: CGFloat = 130
           return CGSize(width: width, height: height)
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }

}

extension HomeViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = !searchText.isEmpty

        viewModel.fetchGames(searchText)
        pageViewController.view.isHidden = viewModel.isHeaderHidden
        pageControl.isHidden = viewModel.isHeaderHidden

        pageViewController.setViewControllers([pages.first].compactMap { $0 }, direction: .forward, animated: false, completion: nil)

                  }
   

      }
   
        
           
        
 

extension HomeViewController: HomeViewModelDelegate {
    

    func detailDownloadFinished(
        selectedGame: Games,
        gameDetails: VideoGames
    ) {
        DispatchQueue.main.async {
            let detailsViewController = DetailsViewController()
            detailsViewController.gameName = selectedGame.name
            detailsViewController.releasedDate = selectedGame.released
            detailsViewController.metacriticR = "Metacritic Rate: \(String(describing: selectedGame.metacritic.map { String($0) }))"
            detailsViewController.detailsL = gameDetails.description
            detailsViewController.gameid = selectedGame.id


            DispatchQueue.global().async {
                if let backgroundImageURLString = selectedGame.backgroundImage,
                   let backgroundImageURL = URL(string: backgroundImageURLString),
                   let imageData = try? Data(contentsOf: backgroundImageURL) {
                    DispatchQueue.main.async {
                        detailsViewController.gameImage = UIImage(data: imageData)
                        detailsViewController.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(detailsViewController, animated: true)
                    }
                }
            }
        }
    }
    private func setupPages(with viewModels: [PageViewModel]) {
            self.pages = viewModels.map { createPageViewController(with: $0) }
            self.pageControl.numberOfPages = self.pages.count
            self.pageViewController.setViewControllers([self.pages.first].compactMap { $0 }, direction: .forward, animated: true, completion: nil)
        }

        func gamesListDownloadFinished() {
            let firstThreeGames = viewModel.getFirstThreeGames()
            let pageViewModels = firstThreeGames.map { PageViewModel(game: $0) }

            setupPages(with: pageViewModels)
            collectionView.reloadData()
        }     }
