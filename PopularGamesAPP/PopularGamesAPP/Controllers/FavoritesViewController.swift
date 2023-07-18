//
//  FavoritesViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//


//import GamesAPI
//import UIKit
//import CoreData
//class FavoriteViewController: UIViewController {
//
//     var collectionView: UICollectionView!
//    var favoriteGames: [GamesCoreData] = []
//    var games: [Games] = []
//    let service = GamesService()
//    private var deleteAllFavoritesButton: UIButton = {
//        let button = UIButton()
//        button.imageView?.image = UIImage(systemName: "trash")
//
//        button.backgroundColor = .red
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(FavoriteViewController.self, action: #selector(deleteAllFavoritesTapped), for: .touchUpInside)
//        return button
//    }()
//    @objc private func deleteAllFavoritesTapped() {
//            // Perform the deletion of all favorite games from Core Data
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let managedContext = appDelegate.persistentContainer.viewContext
//                let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
//
//                do {
//                    let favorites = try managedContext.fetch(fetchRequest)
//                    for game in favorites {
//                        managedContext.delete(game)
//                    }
//                    try managedContext.save()
//                    favoriteGames.removeAll()
//                    collectionView.reloadData()
//                } catch {
//                    print("Error deleting favorite games: \(error.localizedDescription)")
//                }
//            }
//        }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      setup()
//      layout()
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
//           fetchFavoriteGames()
//           collectionView.reloadData()
//       }
//
//    private func fetchFavoriteGames() {
//
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let managedContext = appDelegate.persistentContainer.viewContext
//                let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
//
//                do {
//                    favoriteGames = try managedContext.fetch(fetchRequest)
//                } catch {
//                    print("Error fetching favorite games: \(error.localizedDescription)")
//                }
//            }
//        }
//}
//extension FavoriteViewController {
//    private func setup(){
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    private func layout() {
//        view.addSubview(collectionView)
//        view.addSubview(deleteAllFavoritesButton)
//             deleteAllFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
//        let deleteAllFavoritesButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteAllFavoritesTapped))
//                navigationItem.rightBarButtonItem = deleteAllFavoritesButton
//
//         }
//    }
//
//extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return favoriteGames.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell
//
//
//        let game = favoriteGames[indexPath.item]
//        cell.configure(with: game)
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedGame = favoriteGames[indexPath.row]
//        service.fetchGameDetails(with: Int(selectedGame.id)) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let gameDetails):
//                DispatchQueue.main.async {
//                    let detailsViewController = DetailsViewController()
//                    detailsViewController.gameName = selectedGame.name
//                    detailsViewController.releasedDate = selectedGame.released
//                    detailsViewController.detailsL = gameDetails.description
//                    detailsViewController.gameid = selectedGame.id
//                    detailsViewController.metacriticRate.isHidden = true
//                    if let backgroundImageData = Data(base64Encoded: selectedGame.backgroundImage ?? ""),
//                       let backgroundImage = UIImage(data: backgroundImageData) {
//                        detailsViewController.gameImage = backgroundImage
//                    }
//
//                    detailsViewController.hidesBottomBarWhenPushed = true
//
//                    self.navigationController?.pushViewController(detailsViewController, animated: true)
//                }
//            case .failure(let error):
//                print("FetchGameDetails Error: \(error)")
//            }
//        }
//    }
//
//
//
//}
//
//
//extension FavoriteViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 30) / 2
//        return .init(width: width, height: width + 50)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 10, left: 10, bottom: 10, right: 10)
//    }
//}
import UIKit
import CoreData
class FavoriteViewController: UIViewController {
    
    
     var collectionView: UICollectionView!
    var viewModel: FavoriteViewModel!
//    var favoriteGames: [GamesCoreData] = []

    private var deleteAllFavoritesButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "trash")
      
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(FavoriteViewController.self, action: #selector(deleteAllFavoritesTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
   
           viewModel = FavoriteViewModel()
           viewModel.delegate = self // ViewModel'e delegesini atıyoruz
           setup()
           layout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchFavoriteGames()
           collectionView.reloadData()
       }
 
    private func fetchFavoriteGames() {
        viewModel.fetchFavoriteGames()
    }

    @objc private func deleteAllFavoritesTapped() {
        viewModel.deleteAllFavoriteGames()
    }

}
extension FavoriteViewController: FavoriteViewModelDelegate {
    func didFetchFavoriteGames() {
        collectionView.reloadData()
    }
}

extension FavoriteViewController {
    private func setup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(deleteAllFavoritesButton)
             deleteAllFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        let deleteAllFavoritesButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteAllFavoritesTapped))
                navigationItem.rightBarButtonItem = deleteAllFavoritesButton
             
         }
    }

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFavoriteGames()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell

        let game = viewModel.favoriteGame(at: indexPath.item)
        cell.configure(with: game)

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = viewModel.favoriteGame(at: indexPath.row)
        viewModel.service.fetchGameDetails(with: Int(selectedGame.id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameDetails):
                DispatchQueue.main.async {
                    let detailsViewController = DetailsViewController()
                    detailsViewController.gameName = selectedGame.name
                    detailsViewController.releasedDate = selectedGame.released
                    detailsViewController.detailsL = gameDetails.description
                    detailsViewController.gameid = selectedGame.id
                    detailsViewController.metacriticRate.isHidden = true
                    if let backgroundImageData = Data(base64Encoded: selectedGame.backgroundImage ?? ""),
                       let backgroundImage = UIImage(data: backgroundImageData) {
                        detailsViewController.gameImage = backgroundImage
                    }
                    
                    detailsViewController.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(detailsViewController, animated: true)
                }
            case .failure(let error):
                print("FetchGameDetails Error: \(error)")
            }
        }
    }



}


extension FavoriteViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30) / 2
        return .init(width: width, height: width + 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
