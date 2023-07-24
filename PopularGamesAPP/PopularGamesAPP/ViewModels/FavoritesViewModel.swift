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

class FavoriteViewModel {
    weak var delegate: FavoriteViewModelDelegate?
    public let service = GamesService()
    private var favoriteGames: [GamesCoreData] = []

    func fetchFavoriteGames() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()

            do {
                favoriteGames = try managedContext.fetch(fetchRequest)
                delegate?.didFetchFavoriteGames()
            } catch {
                print("Error fetching favorite games: \(error.localizedDescription)")
            }
        }
    }

    func deleteAllFavoriteGames() {
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
                delegate?.didFetchFavoriteGames()
            } catch {
                print("Error deleting favorite games: \(error.localizedDescription)")
            }
        }
    }

    func numberOfFavoriteGames() -> Int {
        return favoriteGames.count
    }

    func favoriteGame(at index: Int) -> GamesCoreData {
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



