//
//  HomeViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import Foundation
import GamesAPI
// MARK: - PageController Calculates
extension HomeViewModel {
    fileprivate enum Constants {
        static let pageControllerGameCount: Int = 3
    }
}
// MARK: - HomeViewModel Delegate
protocol HomeViewModelDelegate: AnyObject {
    func gamesListDownloadFinished()
}
// MARK: - HomeViewModel Protocol
protocol HomeViewModelProtocol: AnyObject {
    
    var gamesCount: Int { get }
    var games: [Games] { get set }
    var pageViewControllerGameCount: Int { get }
    var isHeaderHidden: Bool { get }
    func sortGamesByRating()
    var delegate: HomeViewModelDelegate? { get set }
    func sortGamesByName()
    func fetchGames(_ searchText: String?)
    var originalGamesOrder: [Games] { get set }
    func downloadGames(_ searchText: String?)
    func getFirstThreeGames() -> [Games]
    func getGame(index: Int,pageController: Bool) -> Games
    func sortGmesBySmallRating()
}
// MARK: - HomeViewModel Class
final class HomeViewModel {
    var allGames: [Games] = []
    var games: [Games] = []
    var pageControlGames : [Games] = []
    var service : GamesServiceProtocol
    var currentPageIndex = 0
    var isHeaderHidden: Bool = true
    var originalGamesOrder: [Games] = []
    
    weak var delegate: HomeViewModelDelegate?
    
    init(service: GamesServiceProtocol = GamesService()) {
        self.service = service
    }
    
    // MARK: - Search Bar Method
    @objc private func performSearch(
        _ searchText: String?
    ) {
        guard let searchText else {
            return
        }
        
        var filteredGames = allGames.filter {
            if searchText.isEmpty {
                return true
            }
            
            return  ($0.name ?? "").lowercased().contains(searchText.lowercased())
            
        }
        if searchText.isEmpty {
            filteredGames = Array(filteredGames.dropFirst(3))
        }
        games = filteredGames
        
    }
}
// MARK: - HomeViewModel Extension
extension HomeViewModel: HomeViewModelProtocol {
    func sortGamesByRating() {
        
        games.sort { game1, game2 in
            if let rating1 = game1.rating, let rating2 = game2.rating {
                return rating1 > rating2
            } else {
                
                return false
            }
        }
    }
    
    func sortGmesBySmallRating(){
        games.sort { game1, game2 in
            if let rating1 = game1.rating, let rating2 = game2.rating {
                return rating1 < rating2
            } else {
                
                return false
            }
        }
    }
    func sortGamesByName() {
        games.sort { game1, game2 in
            guard let name1 = game1.name?.lowercased(), let name2 = game2.name?.lowercased() else {
                return false
            }
            return name1 < name2
        }
    }
    var gamesCount: Int {
        
        return games.count
    }
    
    var pageViewControllerGameCount: Int {
        Constants.pageControllerGameCount
    }
    
    func getFirstThreeGames() -> [Games] {
        return Array(allGames.prefix(3))
    }
    
    func fetchGames(
        _ searchText: String?
    ) {
        
        let count = (searchText?.count ?? 0)
        
        if count == 0 {
            isHeaderHidden = false
            downloadGames(nil)
        }
        else if count < 3 {
            isHeaderHidden = false
            performSearch(nil)
            delegate?.gamesListDownloadFinished()
        }
        else if count == 3 {
            isHeaderHidden = true
            performSearch(searchText)
            delegate?.gamesListDownloadFinished()
        } else {
            isHeaderHidden = true
            downloadGames(searchText)
        }
    }
    //MARK: - Fetch Games Call/ PageViewController Setup
    func downloadGames(
        _ searchText: String?
    ) {
        service.fetchGames() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let games):
                
                self.allGames = games
                
                if searchText?.isEmpty ?? true {
                    self.pageControlGames = Array(games.prefix(3))
                    self.games = Array(games.dropFirst(3))
                } else {
                    self.performSearch(searchText)
                }
                
                delegate?.gamesListDownloadFinished()
                
            case .failure(let error):
                print("FetchGames Error: \(error)")
            }
        }
    }
    
    func getGame(index: Int, pageController:Bool) -> Games {
        
        return pageController ? pageControlGames[index] : games[index]
    }
}

