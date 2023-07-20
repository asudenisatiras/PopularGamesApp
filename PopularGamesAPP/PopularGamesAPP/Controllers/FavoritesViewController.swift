//
//  FavoritesViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit
import CoreData
class FavoriteViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var viewModel: FavoriteViewModel!
   
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
           viewModel.delegate = self
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
        collectionView.register(EmptyFavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "NoFavoritesCell")
        collectionView.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)
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
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.numberOfFavoriteGames()
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfFavorites = viewModel.numberOfFavoriteGames()
        if numberOfFavorites == 0 {
            // Eğer favorilerde oyun yoksa, bir görüntü döndür
            return 1
        }
        return numberOfFavorites
    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell
//
//        let game = viewModel.favoriteGame(at: indexPath.item)
//        cell.configure(with: game)
//
//        return cell
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberOfFavorites = viewModel.numberOfFavoriteGames()
        if numberOfFavorites == 0 {
            // Favorilerde oyun yok, görüntü hücresi oluştur
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoFavoritesCell", for: indexPath) as! EmptyFavoritesCollectionViewCell
            return imageCell
        } else {
            // Favori oyun hücresi oluştur
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell

            let game = viewModel.favoriteGame(at: indexPath.item)
            cell.configure(with: game)

            return cell
        }
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
