//
//  HomeViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

//import UIKit
//import GamesAPI
//class HomeViewController: UIViewController, UISearchBarDelegate{
//
//    private let reuseIdentifier = "FavoriteCell"
//    var pageViewController: UIPageViewController!
//       var pages: [UIViewController] = []
//       var pageControl: UIPageControl!
//    var collectionView: UICollectionView!
//    var games: [Games] = []
//    let service = GamesService()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        layout()
//        fetchGames()
//    }
//    fileprivate func fetchGames() {
//        service.fetchGames() { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let games):
//                DispatchQueue.main.async {
//                    self.games = games
//                    self.collectionView.reloadData()
//
//                }
//            case .failure(let error):
//                print("FetchGames Error: \(error)")
//            }
//        }
//    }
//}
//
//extension HomeViewController {
//    private func setup(){
//        view.backgroundColor = .white
//        let firstPage = UIViewController()
//                firstPage.view.backgroundColor = .red
//                let secondPage = UIViewController()
//                secondPage.view.backgroundColor = .green
//                let thirdPage = UIViewController()
//                thirdPage.view.backgroundColor = .blue
//
//
//                pages = [firstPage, secondPage, thirdPage]
//
//
//                pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//                pageViewController.view.layer.cornerRadius = 12
//                pageViewController.dataSource = self
//                pageViewController.delegate = self
//                pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
//
//                addChild(pageViewController)
//                view.addSubview(pageViewController.view)
//
//                pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//               pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//               pageViewController.view.widthAnchor.constraint(equalToConstant: 100),
//               pageViewController.view.heightAnchor.constraint(equalToConstant: 150),
//               pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
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
//          collectionView.register(GamesListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//          collectionView.delegate = self
//          collectionView.dataSource = self
//          view.addSubview(collectionView)
//
//
//          collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//          collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
//          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
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
//
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
//}
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         return games.count
//    }
//     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GamesListCollectionViewCell
//         let games = self.games[indexPath.row]
//         cell.configure(games: games)
//            return cell
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//          let detailsViewController = DetailsViewController()
//          navigationController?.pushViewController(detailsViewController, animated: true)
//      }
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
//}
//
//ENSON ALTINDAKİ
//import UIKit
//import GamesAPI
//class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate{
//
//    private let reuseIdentifier = "FavoriteCell"
//    var pageViewController: UIPageViewController!
//       var pages: [UIViewController] = []
//       var pageControl: UIPageControl!
//    var collectionView: UICollectionView!
//    var games: [Games] = []
//    let service = GamesService()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        layout()
//        fetchGames()
//        setupp()
//    }
//    fileprivate func fetchGames() {
//        service.fetchGames() { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let games):
//                DispatchQueue.main.async {
//                    let firstThreeGames = Array(games.prefix(3)) // İlk üç oyun
//                    self.pages = firstThreeGames.map { self.createPageViewController(with: $0) }
//                    self.pageControl.numberOfPages = self.pages.count
//
//                    self.games = Array(games.dropFirst(3)) // Geri kalan oyunlar
//                    self.collectionView.reloadData()
//
//                    // Eklenen yeni kod
//                    self.pageViewController.setViewControllers([self.pages.first].compactMap { $0 }, direction: .forward, animated: true, completion: nil)
//                }
//            case .failure(let error):
//                print("FetchGames Error: \(error)")
//            }
//        }
//    }
//
//
////    private func createPageViewController(with game: Games) -> UIViewController {
////        let detailsViewController = DetailsViewController()
////        detailsViewController.gameName = game.name
////        detailsViewController.releasedDate = game.released
////        detailsViewController.metacriticR = game.metacritic.map { String($0) }
////        if let backgroundImageURLString = game.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
////            detailsViewController.gameImage = UIImage(data: imageData)
////        }
////        return detailsViewController
////    }
//    private func createPageViewController(with game: Games) -> UIViewController {
//        let detailsViewController = DetailsViewController()
//        detailsViewController.gameName = game.name
//        detailsViewController.releasedDate = game.released
//        detailsViewController.metacriticR = game.metacritic.map { String($0) }
//        if let backgroundImageURLString = game.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
//            detailsViewController.gameImage = UIImage(data: imageData)
//        }
//        detailsViewController.view.contentMode = .scaleAspectFill
//        return detailsViewController
//    }
//
//
//}
//
//extension HomeViewController {
//    private func setup(){
//
//        view.backgroundColor = .white
////        let firstPage = UIViewController()
////                firstPage.view.backgroundColor = .red
////                let secondPage = UIViewController()
////                secondPage.view.backgroundColor = .green
////                let thirdPage = UIViewController()
////                thirdPage.view.backgroundColor = .blue
//
//
//              //  pages = [firstPage, secondPage, thirdPage]
//
//
//                pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//                pageViewController.view.layer.cornerRadius = 12
//                pageViewController.dataSource = self
//                pageViewController.delegate = self
//            //    pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
//
//                addChild(pageViewController)
//                view.addSubview(pageViewController.view)
//
//                pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//               pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//               pageViewController.view.widthAnchor.constraint(equalToConstant: 100),
//               pageViewController.view.heightAnchor.constraint(equalToConstant: 150),
//               pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
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
//          collectionView.register(GamesListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//          collectionView.delegate = self
//          collectionView.dataSource = self
//          view.addSubview(collectionView)
//
//
//          collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//          collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
//          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
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
//
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
//           // ...
//
//           let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pageViewControllerTapped))
//           pageViewController.view.addGestureRecognizer(tapGestureRecognizer)
//           tapGestureRecognizer.delegate = self
//       }
//
////    @objc private func pageViewControllerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
////        if let currentViewController = pageViewController.viewControllers?.first, let currentIndex = pages.firstIndex(of: currentViewController) {
////            let selectedGame = games[currentIndex]
////            let detailsViewController = DetailsViewController()
////            detailsViewController.gameName = selectedGame.name
////            detailsViewController.releasedDate = selectedGame.released
////            detailsViewController.metacriticR = selectedGame.metacritic.map { String($0) }
////            if let backgroundImageURLString = selectedGame.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
////                detailsViewController.gameImage = UIImage(data: imageData)
////            }
////            navigationController?.pushViewController(detailsViewController, animated: true)
////        }
////    }
//    @objc private func pageViewControllerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
//        if let currentViewController = pageViewController.viewControllers?.first as? DetailsViewController {
//            if let currentIndex = pages.firstIndex(of: currentViewController) {
//                let selectedGame = games[currentIndex]
//                currentViewController.gameName = selectedGame.name
//                currentViewController.releasedDate = selectedGame.released
//                currentViewController.metacriticR = selectedGame.metacritic.map { String($0) }
//                if let backgroundImageURLString = selectedGame.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString) {
//                    URLSession.shared.dataTask(with: backgroundImageURL) { [weak currentViewController] (data, response, error) in
//                        guard let data = data, let image = UIImage(data: data), error == nil else {
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            currentViewController?.gameImage = image
//                        }
//                    }.resume()
//                }
//
//                navigationController?.pushViewController(currentViewController, animated: true)
//            }
//        }
//    }
//
//}
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         return games.count
//    }
//     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GamesListCollectionViewCell
//         let games = self.games[indexPath.row]
//         cell.configure(games: games)
//            return cell
//
//    }
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////          let detailsViewController = DetailsViewController()
////          navigationController?.pushViewController(detailsViewController, animated: true)
////      }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedGame = games[indexPath.row]
//        let detailsViewController = DetailsViewController()
//        detailsViewController.gameName = selectedGame.name
//        detailsViewController.releasedDate = selectedGame.released
//        detailsViewController.metacriticR = selectedGame.metacritic.map { String($0) }
//        if let backgroundImageURLString = selectedGame.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
//               detailsViewController.gameImage = UIImage(data: imageData)
//           }
//        navigationController?.pushViewController(detailsViewController, animated: true)
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
//}
//
import UIKit
import GamesAPI // data models are defined in the API

class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    var pageViewController: UIPageViewController!
    var pages: [UIViewController] = []
    var pageControl: UIPageControl!
    var collectionView: UICollectionView!

    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        viewModel.downloadGames(nil)
        setupp()
    }

    private func createPageViewController(with game: Games) -> UIViewController {
        let newViewController = PageViewController()
        
        newViewController.gameName = game.name
  
        if let backgroundImageURLString = game.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
            newViewController.gameImage = UIImage(data: imageData)
        }

        return newViewController
    }



}

extension HomeViewController {
    private func setup(){
        
        view.backgroundColor = .white
        
                pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                pageViewController.view.layer.cornerRadius = 12
                pageViewController.dataSource = self
                pageViewController.delegate = self
       
                addChild(pageViewController)
                view.addSubview(pageViewController.view)

                pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
               pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               pageViewController.view.widthAnchor.constraint(equalToConstant: 100),
               pageViewController.view.heightAnchor.constraint(equalToConstant: 220),
               pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
           ])

                pageControl = UIPageControl()
                pageControl.translatesAutoresizingMaskIntoConstraints = false
                pageControl.currentPageIndicatorTintColor = .systemRed
                pageControl.pageIndicatorTintColor = .gray
                pageControl.numberOfPages = pages.count
                view.addSubview(pageControl)

                NSLayoutConstraint.activate([
                    pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    pageControl.bottomAnchor.constraint(equalTo: pageViewController.bottomLayoutGuide.bottomAnchor, constant: 22)
                ])

          collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
          let flowLayout = UICollectionViewFlowLayout()
          flowLayout.scrollDirection = .vertical
          collectionView.register(GamesListCollectionViewCell.self,
                                  forCellWithReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier)
          collectionView.delegate = self
          collectionView.dataSource = self
          view.addSubview(collectionView)


          collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

                pageViewController.didMove(toParent: self)
       
            }

    private func layout() {
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.delegate = self
        }
    }

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
                    index: currentIndex - viewModel.pageViewControllerGameCount
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
        cell.backgroundColor = .systemGray4

        let games = viewModel.getGame(index: indexPath.row)//self.games[indexPath.row]
         
        
        cell.configure(games: games)
         return cell
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.fetchGameDetails(index: indexPath.row)
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchGames(searchText)
    }
    
    private func printGameDetails(_ game: Games, _ videoGame: VideoGames) {
        print("Game ID: \(game.id)")
        print("Game Name: \(game.name)")
        print("Released Date: \(game.released ?? "")")
        print("Metacritic Score: \(game.metacritic ?? 0)")
        print("Background Image URL: \(game.backgroundImage ?? "")")
        print("Description: \(videoGame.description ?? "")")
       
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
            detailsViewController.metacriticR = selectedGame.metacritic.map { String($0) }
            detailsViewController.detailsL = gameDetails.description
            detailsViewController.gameid = selectedGame.id
            if let backgroundImageURLString = selectedGame.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString), let imageData = try? Data(contentsOf: backgroundImageURL) {
                detailsViewController.gameImage = UIImage(data: imageData)
            }
            detailsViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func gamesListDownloadFinished() {
        let firstThreeGames = viewModel.getFirstThreeGames()
        self.pages = firstThreeGames.map { self.createPageViewController(with: $0) }
        self.pageControl.numberOfPages = self.pages.count
        
        collectionView.reloadData()
        self.pageViewController.setViewControllers([self.pages.first].compactMap { $0 }, direction: .forward, animated: true, completion: nil)
    }
}
