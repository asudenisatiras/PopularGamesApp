//
//  MockFavoritesViewModel.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 22.07.2023.
//

import Foundation
import XCTest
@testable import PopularGamesAPP

var isInvokeddidFetchFavoriteGames = false
var invokeddidFetchFavoriteGamesCount = 0

func didFetchFavoriteGames(){
    isInvokeddidFetchFavoriteGames = true
    invokeddidFetchFavoriteGamesCount += 1
}
