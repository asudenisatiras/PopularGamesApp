//
//  HomeViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import Foundation
import GamesAPI

extension HomeViewModel {
    fileprivate enum Constants {
        static let pageControllerGameCount: Int = 3
    }
}

protocol HomeViewModelDelegate: AnyObject {
    func gamesListDownloadFinished()
    
}

protocol HomeViewModelProtocol: AnyObject {

    var gamesCount: Int { get }
    var games: [Games] { get set }
    var pageViewControllerGameCount: Int { get }
    var isHeaderHidden: Bool { get }

    var delegate: HomeViewModelDelegate? { get set }

    func fetchGames(_ searchText: String?)
    
    func downloadGames(_ searchText: String?)
    func getFirstThreeGames() -> [Games]
    func getGame(index: Int,pageController: Bool) -> Games
}

final class HomeViewModel: NSObject {
    var allGames: [Games] = []
    var games: [Games] = []
    var pageControlGames : [Games] = []
    var service : GamesServiceProtocol
    var currentPageIndex = 0
    var isHeaderHidden: Bool = true

    weak var delegate: HomeViewModelDelegate?

    
    init(service: GamesServiceProtocol = GamesService()) {
        self.service = service
        
    }
    
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

extension HomeViewModel: HomeViewModelProtocol {
    
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

