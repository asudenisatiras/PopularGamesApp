//
//  PageControllerViewModel.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 20.07.2023.
//

import Foundation
import GamesAPI
class PageViewModel {
    var game: Games
    var gameName: String {
        return game.name!
    }
    var gameImage: Data?

    init(game: Games) {
        self.game = game
    }

    func loadGameImage(completion: @escaping (Data?) -> Void) {
        guard let backgroundImageURLString = game.backgroundImage, let backgroundImageURL = URL(string: backgroundImageURLString) else {
            completion(nil)
            return
        }

        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: backgroundImageURL) {
                self.gameImage = imageData
                DispatchQueue.main.async {
                    completion(imageData)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
