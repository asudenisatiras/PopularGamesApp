//
//  FavoritesViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import UIKit
import CoreData
import GamesAPI

protocol FavoriteViewModelDelegate: AnyObject {
    func didFetchFavoriteGames()
}
protocol FavoriteViewModelProtocol{
    var delegate : FavoriteViewModelDelegate? { get set }
    func fetchFavoriteGames()
    func deleteAllFavoriteGames()
    func numberOfFavoriteGames() -> Int
    func favoriteGame(at index: Int) -> Games
}
class FavoriteViewModel: FavoriteViewModelProtocol {
    weak var delegate: FavoriteViewModelDelegate?
    public let service : GamesServiceProtocol
    public let coreDataService : CoreDataManagerProtocol
    private var favoriteGames: [Games] = []
    
    
    init(service: GamesServiceProtocol = GamesService(), coreDataService : CoreDataManagerProtocol = CoreDataManager.shared ) {
        self.service = service
        self.coreDataService = coreDataService
    }
    
    
    func fetchFavoriteGames() {
        favoriteGames = coreDataService.fetchFavoriteGames()
        delegate?.didFetchFavoriteGames()
        
    }
    
    func deleteAllFavoriteGames() {
        let isDeleted = coreDataService.deleteAllFavoriteGames()
        if isDeleted {
            favoriteGames.removeAll()
            delegate?.didFetchFavoriteGames()
        } else {
            print("Deleted all favorites.")
        }
    }
    
    func numberOfFavoriteGames() -> Int {
        return favoriteGames.count
    }
    
    func favoriteGame(at index: Int) -> Games {
        return favoriteGames[index]
    }
    
    func fetchGameDetails(for selectedGame: GamesCoreData, completion: @escaping (Result<GamesDetails, Error>) -> Void) {
        service.fetchGameDetails(with: Int(selectedGame.id)) { result in
            switch result {
            case .success(let gameDetails):
                completion(.success(gameDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



