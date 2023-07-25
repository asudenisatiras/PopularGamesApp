//
//  CoreData+Helpers.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 16.07.2023.
//
import GamesAPI
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func addFavoriteGame(id: Int32)
    func isGameFavorite(id: Int32) -> Bool
    func saveGameData(name: String, released: String, backgroundImage: String, id: Int32)
    func deleteGameData(withId id: Int32)
    func isGameIdSaved(_ id: Int32) -> Bool
    func removeFavoriteGame(id: Int32)
    func fetchFavoriteGames() -> [Games]
    func deleteAllFavoriteGames() -> Bool
}
class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    private var favoriteGameIds: Set<Int32> = []
    
    func addFavoriteGame(id: Int32) {
        favoriteGameIds.insert(id)
    }
    
    
    func isGameFavorite(id: Int32) -> Bool {
        return favoriteGameIds.contains(id)
    }
    
    
    func saveGameData(name: String, released: String, backgroundImage: String, id: Int32) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newGame = NSEntityDescription.insertNewObject(forEntityName: "GamesCoreData", into: context)
        newGame.setValue(name, forKey: "name")
        newGame.setValue(released, forKey: "released")
        newGame.setValue(id, forKey: "id")
        newGame.setValue(backgroundImage, forKey: "backgroundImage")
        
        do {
            try context.save()
            favoriteGameIds.insert(id)
            print("Kayıt başarılı")
        } catch {
            print("Kayıt başarısız: \(error.localizedDescription)")
        }
    }
    
    func deleteGameData(withId id: Int32) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let games = results as? [NSManagedObject], let game = games.first {
                context.delete(game)
                favoriteGameIds.remove(id)
                try context.save()
                print("Veri silindi. ID: \(id)")
            }
        } catch {
            print("Veri silinemedi: \(error.localizedDescription)")
        }
    }
    func isGameIdSaved(_ id: Int32) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print("Veri sorgulanırken hata oluştu: \(error.localizedDescription)")
        }
        
        return false
    }
    func removeFavoriteGame(id: Int32) {
        favoriteGameIds.remove(Int32(Int(id)))
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let games = results as? [NSManagedObject], let game = games.first {
                context.delete(game)
                try context.save()
                print("Veri silindi. ID: \(id)")
            }
        } catch {
            print("Veri silinemedi: \(error.localizedDescription)")
        }
    }
    func fetchFavoriteGames() -> [Games] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                return result.map({
                    Games(id: $0.id,
                          name: $0.name,
                          released: $0.released,
                          backgroundImage: $0.backgroundImage,
                          rating: nil,
                          ratingTop: nil,
                          metacritic: nil)
                })
            } catch {
                return []
            }
        } else {
            return []
        }
    }
    func deleteAllFavoriteGames() -> Bool {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<GamesCoreData> = GamesCoreData.fetchRequest()
            
            do {
                let favorites = try managedContext.fetch(fetchRequest)
                for game in favorites {
                    managedContext.delete(game)
                }
                try managedContext.save()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
}

