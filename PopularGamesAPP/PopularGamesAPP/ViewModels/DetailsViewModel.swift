//
//  DetailsViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 24.07.2023.
//

import Foundation
import GamesAPI
import Foundation
protocol DetailsViewModelProtocol {
    func fetchGameDetails(gamesId: Int)
    var gameName: String? { get }
    var metacriticRate: Int? { get }
    var releasedDate: String? { get }
    var description: String? { get }
    var gameId: Int32? {get}
    var delegate: DetailsViewModelDelegate? { get set }
    func imageDownloadStart()
   
}
protocol DetailsViewModelDelegate : AnyObject {
    func detailDownloadFinished()
    func imageDownloadFinished(data:Data)
} // weak veya unowned keywordleri birer referansı soylemekte, protokolller de sadece referans tipinde olunca o yuzden any object kullanıyoruz.
// neden weak delegate? herhangi bir seyi delegate olarak isaretliyosak bellekten atılırken alt degiskeni silmeli miyim??
final class DetailsViewModel: DetailsViewModelProtocol {
    var gameId: Int32? {
        gameDetails?.id
    }
    
    func imageDownloadStart() {
        guard let backgroundImageURLString = gameDetails?.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString) else {
            
            return
        }
        if let imageData = try? Data(contentsOf: backgroundImageURL) {
            delegate?.imageDownloadFinished(data: imageData)
        } else {
            //TODO: error durumunu düşünerek delegate'ye ekle!!
        }
    }
    
    var description: String? {
        gameDetails?.description
    }
    
    
    init(gamesId:Int){
        fetchGameDetails(gamesId: gamesId)
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
    

    let service = GamesService()
    var gameDetails : GamesDetails?
    weak var delegate: DetailsViewModelDelegate?
    
    func fetchGameDetails(gamesId: Int) {
        
        service.fetchGameDetails(with: Int(gamesId)) { [weak self] result in
            guard let self = self else { return }
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
