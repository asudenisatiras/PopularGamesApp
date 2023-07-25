//
//  MockCoreDataService.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 25.07.2023.
//
import CoreData
import Foundation
import GamesAPI
@testable import PopularGamesAPP

class MockCoreDataService: CoreDataManagerProtocol {
    
    
   private var gamesCoreData: [Games] = [
        .init(id: 123, name: "aaa", released: "2000", backgroundImage: "b", rating: 0.0, ratingTop: 3, metacritic: 98)
        
    ]

    private var favoriteGameIds: Set<Int32> = []

    func addFavoriteGame(id: Int32) {
        favoriteGameIds.insert(id)
    }

    func isGameFavorite(id: Int32) -> Bool {
        return favoriteGameIds.contains(id)
    }

    func saveGameData(name: String, released: String, backgroundImage: String, id: Int32) {
        
        let game = Games(id: id,
                         name: name,
                         released: released,
                         backgroundImage: backgroundImage,
                         rating: nil,
                         ratingTop: nil,
                         metacritic: nil)
        gamesCoreData.append(game)
        favoriteGameIds.insert(id)
        print("Kayıt başarılı")
    }

    func deleteGameData(withId id: Int32) {
       
        if let index = gamesCoreData.firstIndex(where: { $0.id == id }) {
            gamesCoreData.remove(at: index)
            favoriteGameIds.remove(id)
            print("Veri silindi. ID: \(id)")
        }
    }

    func isGameIdSaved(_ id: Int32) -> Bool {
        
        return gamesCoreData.contains(where: { $0.id == id })
    }

//    func removeFavoriteGame(id: Int32) {
//        favoriteGameIds.remove(id)
//
//        if let index = gamesCoreData.firstIndex(where: { $0.id == id }) {
//            gamesCoreData.remove(at: index)
//            print("Veri silindi. ID: \(id)")
//        }
//    }
    func removeFavoriteGame(id: Int32) {
           favoriteGameIds.remove(id)
           // Oyunu gamesCoreData'dan kaldırmadan sadece favoriteGameIds set'inden kaldıralım
       }

    func fetchFavoriteGames() -> [Games] {
       
        return gamesCoreData
    }

//    func deleteAllFavoriteGames() -> Bool {
//        gamesCoreData.removeAll()
//        favoriteGameIds.removeAll()
//        return true
//    }
    func deleteAllFavoriteGames() -> Bool {
            gamesCoreData.removeAll()
            favoriteGameIds.removeAll()
            return true
        }
}
