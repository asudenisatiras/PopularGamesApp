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
    func detailDownloadFinished(
        selectedGame: Games,
        gameDetails: VideoGames
    )
}

protocol HomeViewModelProtocol: AnyObject {
    
    var gamesCount: Int { get }
    
    var pageViewControllerGameCount: Int { get }
    
    var delegate: HomeViewModelDelegate? { get set }
    
    func fetchGames(_ searchText: String?)
    func fetchGameDetails(index: Int)
    func downloadGames(_ searchText: String?)
    func getFirstThreeGames() -> [Games]
    func getGame(index: Int) -> Games
}

final class HomeViewModel: NSObject {
    var allGames: [Games] = []
    var games: [Games] = []
    let service = GamesService()
    var currentPageIndex = 0
    
    weak var delegate: HomeViewModelDelegate?
    
    @objc private func performSearch(
        _ searchText: String?
    ) {
        guard let searchText else {
            return
        }

        let filteredGames = allGames.filter { ($0.name ?? "").lowercased().contains(searchText.lowercased()) }
        games = filteredGames
        //collectionView.reloadData()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    var gamesCount: Int {
        let count = games.count - Constants.pageControllerGameCount
        let difference = abs(count)
        return (count >= 0) ? count : 0
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
        //NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)

        if (searchText?.count ?? 0) <= 3 {
            //perform(#selector(performSearch), with: nil, afterDelay: 0.3)
            performSearch(searchText)
        } else {
            //fetchGames(searchText)
            downloadGames(searchText)
        }
    }
    
    func fetchGameDetails(index: Int) {
        let selectedGame = getGame(index: index)
        service.fetchGameDetails(with: Int(selectedGame.id!)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameDetails):
                delegate?.detailDownloadFinished(
                    selectedGame: selectedGame,
                    gameDetails: gameDetails
                )
                
            case .failure(let error):
                print("FetchGameDetails Error: \(error)")
            }
        }
    }
    
    func downloadGames(
        _ searchText: String?
    ) {
        service.fetchGames() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let games):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.allGames = games

                    if searchText?.isEmpty ?? true {
                        self.games = Array(games)
                    } else {
                        self.performSearch(searchText)
                    }
                    
                    delegate?.gamesListDownloadFinished()
                }
            case .failure(let error):
                print("FetchGames Error: \(error)")
            }
        }
    }
    
    func getGame(index: Int) -> Games {
        return games[index + Constants.pageControllerGameCount]
    }
}
