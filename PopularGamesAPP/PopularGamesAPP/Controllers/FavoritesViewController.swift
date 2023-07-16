//
//  FavoritesViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

//import UIKit
//
//class FavoriteViewController: UIViewController {
//    private let reuseIdentifier = "FavoriteCell"
//     var collectionView: UICollectionView!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      setup()
//      layout()
//
//    }
//
//}
//extension FavoriteViewController {
//    private func setup(){
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    private func layout() {
//        view.addSubview(collectionView)
//
//    }
//}
//extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell
//
//        return cell
//    }
//
//
//}
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
//
import GamesAPI
import UIKit
import CoreData
class FavoriteViewController: UIViewController {
    private let reuseIdentifier = "FavoriteCell"
     var collectionView: UICollectionView!
    var favoriteGames: [GamesCoreData] = []
    private var deleteAllFavoritesButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "trash")
      
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteAllFavoritesTapped), for: .touchUpInside)
        return button
    }()
    @objc private func deleteAllFavoritesTapped() {
            // Perform the deletion of all favorite games from Core Data
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()

                do {
                    let favorites = try managedContext.fetch(fetchRequest)
                    for game in favorites {
                        managedContext.delete(game)
                    }
                    try managedContext.save()
                    favoriteGames.removeAll()
                    collectionView.reloadData()
                } catch {
                    print("Error deleting favorite games: \(error.localizedDescription)")
                }
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
      setup()
      layout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchFavoriteGames()
           collectionView.reloadData()
       }
       
    private func fetchFavoriteGames() {
           
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
                
                do {
                    favoriteGames = try managedContext.fetch(fetchRequest)
                } catch {
                    print("Error fetching favorite games: \(error.localizedDescription)")
                }
            }
        }
}
extension FavoriteViewController {
    private func setup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return favoriteGames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell

        let game = favoriteGames[indexPath.item]
        cell.configure(with: game)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let game = favoriteGames[indexPath.item]

           // Instantiate the DetailsViewController and set its properties based on the selected game.
           let detailsViewController = DetailsViewController()
           detailsViewController.gameName = game.name
           detailsViewController.releasedDate = game.released
      //     detailsViewController.metacriticR = game.metacritic
           // ... Set other properties as needed for the DetailsViewController.

           // Push the DetailsViewController onto the navigation stack to navigate back to the details page.
           self.navigationController?.pushViewController(detailsViewController, animated: true)
       }}


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
