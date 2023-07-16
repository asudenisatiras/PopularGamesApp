//
//  CoreData+Helpers.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 16.07.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
//    private var favoriteGameIds: Set<Int> = []

    private var favoriteGameIds: Set<Int32> = []

       // Favori oyun ID'lerini ekleyen metod
       func addFavoriteGame(id: Int32) {
           favoriteGameIds.insert(id)
       }

       // Oyunun favori olup olmadığını kontrol eden metod
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
               favoriteGameIds.insert(id) // Veritabanına kaydederken aynı zamanda favori setine de ekliyoruz
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
                   favoriteGameIds.remove(id) // Veritabanından silerken aynı zamanda favori setinden de çıkarıyoruz
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

           // Veritabanından silme işlemini gerçekleştiriyoruz.
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
    
}

