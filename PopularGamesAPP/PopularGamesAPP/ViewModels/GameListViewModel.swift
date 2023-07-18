//
//  GameListViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import Foundation
import UIKit
import GamesAPI

protocol GamesListCellViewModelProtocol {
    var gameName: String { get }
    var ratingText: String { get }
    var releaseDateText: String { get }
    func artworkURL() -> URL?
    func configure(cell: GamesListCollectionViewCell)
}
class GamesListCellViewModel: GamesListCellViewModelProtocol {
    private let game: Games

    init(game: Games) {
        self.game = game
    }

    // Computed properties to expose relevant information from the Games object
    var gameName: String {
        return game.name!
    }

    var ratingText: String {
        return "Rating: \(String(format: "%.1f", game.rating ?? 0.0))"
    }

    var releaseDateText: String {
        return "Release Date: \(game.released ?? "")"
    }

    func artworkURL() -> URL? {
        if let artworkUrlString = game.backgroundImage, let artworkUrl = URL(string: artworkUrlString) {
            return artworkUrl
        }
        return nil
    }

    func configure(cell: GamesListCollectionViewCell) {
        cell.gameNameLabel.text = gameName
        cell.ratesLabel.text = ratingText
        cell.releasedDate.text = releaseDateText

        if let artworkUrl = artworkURL() {
            URLSession.shared.dataTask(with: artworkUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.gameImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

