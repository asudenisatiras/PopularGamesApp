//
//  GameListViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import Foundation
import GamesAPI

protocol GamesListCellViewModelProtocol {
    var gameName: String? { get }
    var ratingText: String? { get }
    var releaseDateText: String? { get }
    func downloadImage()
    var delegate: GamesListCellViewModelDelegate? { get set }
        
}
protocol GamesListCellViewModelDelegate : AnyObject {
    func imageDidDownload(_ data: Data)
}
class GamesListCellViewModel: GamesListCellViewModelProtocol {
    private let game: Games
    private var imageDownloadTask: URLSessionDataTask?
    weak var delegate : GamesListCellViewModelDelegate?
    
    init(game: Games) {
        self.game = game
    }

    // Computed properties to expose relevant information from the Games object
    var gameName: String? {
        return game.name
    }

    var ratingText: String? {
        return "\(String(format: "%.1f", game.rating ?? 0.0))"
    }

    var releaseDateText: String? {
        return "Release Date: \(game.released ?? "")"
    }

    func artworkURL() -> URL? {
        if let artworkUrlString = game.backgroundImage, let artworkUrl = URL(string: artworkUrlString) {
            return artworkUrl
        }
        return nil
    }

    func downloadImage() {


        if let artworkUrl = artworkURL() {
            imageDownloadTask?.cancel()
            imageDownloadTask = URLSession.shared.dataTask(with: artworkUrl) { [weak self] (data, response, error) in
                if let data = data {
                    self?.delegate?.imageDidDownload(data)
                    
                }
            }
            imageDownloadTask?.resume()
        }
    }
}

