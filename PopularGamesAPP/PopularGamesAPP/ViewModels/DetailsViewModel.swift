//
//  DetailsViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 24.07.2023.
//

import Foundation
import GamesAPI

protocol DetailsViewModelProtocol {
    func fetchGameDetails(gamesId: Int)
    var gameName: String? { get }
    var metacriticRate: Int? { get }
    var releasedDate: String? { get }
    var description: String? { get }
    var gameId: Int32? {get}
    var delegate: DetailsViewModelDelegate? { get set }
    func imageDownloadStart()
    func isCoreDataSaved () -> Bool
    func removeFavoriteGame ()
    func saveGameData(imageData: String)
}

protocol DetailsViewModelDelegate : AnyObject {
    func detailDownloadFinished()
    func imageDownloadFinished(data:Data)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    func saveGameData(imageData: String) {
        guard let gameName,
              let releasedDate,
              let gameId
        else {
            
            print("Favorite button: Missing required data")
            return
        }
        coreDataService.saveGameData(name: gameName, released: releasedDate, backgroundImage:imageData, id: gameId)
    }
    
    func removeFavoriteGame() {
        if let gameId {
            coreDataService.removeFavoriteGame(id: gameId)
        }
    }
    
    func isCoreDataSaved() -> Bool {
        if let gameId {
            return coreDataService.isGameIdSaved(gameId)
        } else {
            return false
        }
    }
    
    var service : GamesServiceProtocol
    var coreDataService : CoreDataManagerProtocol
    var gameDetails : GamesDetails?
    weak var delegate: DetailsViewModelDelegate?
    var gameId: Int32? {
        gameDetails?.id
    }
    
    var description: String? {
        gameDetails?.description
    }
    
    var gameName: String? {
        gameDetails?.name
    }
    
    var metacriticRate: Int? {
        gameDetails?.metacritic
    }
    
    var releasedDate: String? {
        gameDetails?.released
    }
    
    init(gamesId:Int, service: GamesServiceProtocol = GamesService(), coreDataService: CoreDataManagerProtocol = CoreDataManager.shared){
        self.service = service
        self.coreDataService = coreDataService
        fetchGameDetails(gamesId: gamesId)
        
    }
    func imageDownloadStart() {
        guard let backgroundImageURLString = gameDetails?.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString) else {
            
            return
        }
        if let imageData = try? Data(contentsOf: backgroundImageURL) {
            delegate?.imageDownloadFinished(data: imageData)
        } else {
         print("Image download isn't started.")
        }
    }
    
    func fetchGameDetails(gamesId: Int) {
        
        service.fetchGameDetails(with: Int(gamesId)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let gameDetails):
                self.gameDetails = gameDetails
                delegate?.detailDownloadFinished()
            case .failure(let error):
                print("FetchGameDetails Error: \(error)")
            }
        }
    }
    
}
