//
//  FavoritesViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var viewModel: FavoriteViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
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

//    @objc private func deleteAllFavoritesTapped() {
//        let alertController = UIAlertController(title: "Are you sure you want to delete all your favorite games?", message: nil, preferredStyle: .actionSheet)
//
//        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
//            self?.viewModel.deleteAllFavoriteGames()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alertController.addAction(deleteAction)
//        alertController.addAction(cancelAction)
//
//        present(alertController, animated: true, completion: nil)
//    }
    @objc private func deleteAllFavoritesTapped() {
        let alertController = UIAlertController(title: "Are you sure you want to delete all your favorite games?", message: nil, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteAllFavoriteGames()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfFavorites = viewModel.numberOfFavoriteGames()
        if numberOfFavorites == 0 {
            
            return 1
        }
        return numberOfFavorites
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberOfFavorites = viewModel.numberOfFavoriteGames()
        if numberOfFavorites == 0 {
            
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoFavoritesCell", for: indexPath) as! EmptyFavoritesCollectionViewCell
            return imageCell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.reuseIdentifier, for: indexPath) as! FavoritesCollectionViewCell
            
            let game = viewModel.favoriteGame(at: indexPath.item)
            cell.configure(with: game)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let gameId = viewModel.favoriteGame(at: indexPath.row).id else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewController = DetailsViewController()
            detailsViewController.viewModel = DetailsViewModel(gamesId: Int(gameId))
            
            detailsViewController.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
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
