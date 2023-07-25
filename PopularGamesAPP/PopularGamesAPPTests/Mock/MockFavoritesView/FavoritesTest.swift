//
//  FavoritesTest.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 25.07.2023.
//
import XCTest
import GamesAPI
@testable import PopularGamesAPP

class FavoriteViewModelTests: XCTestCase {
    var favoriteViewModel: FavoriteViewModel!
    var mockService: MockServiceAPI!
    var mockCoreDataManager: MockCoreDataService!

    override func setUp() {
        super.setUp()
     
        mockService = MockServiceAPI()
        mockCoreDataManager = MockCoreDataService()

        
        favoriteViewModel = FavoriteViewModel(service: mockService, coreDataService: mockCoreDataManager)
    }

    override func tearDown() {
        favoriteViewModel = nil
        mockService = nil
        mockCoreDataManager = nil
        super.tearDown()
    }

    func testSaveGameToCoreData() {
        let gameName = "Test Game"
        let releasedDate = "2023-07-26"
        let gameId: Int32 = 123

        mockCoreDataManager.saveGameData(name: gameName, released: releasedDate, backgroundImage: "image", id: gameId)

        XCTAssertTrue(favoriteViewModel.coreDataService.isGameIdSaved(gameId), "Game should be saved to Core Data")
    }

    func testDeleteGameFromCoreData() {
        
        let gameId: Int32 = 123
        mockCoreDataManager.saveGameData(name: "Test Game", released: "2023-07-26", backgroundImage: "image", id: gameId)

        XCTAssertTrue(favoriteViewModel.coreDataService.isGameIdSaved(gameId), "Game should be saved to Core Data before deletion")

        mockCoreDataManager.removeFavoriteGame(id: gameId)

        XCTAssertTrue(favoriteViewModel.coreDataService.isGameIdSaved(gameId), "Game should be removed from Core Data after deletion")
    }

}
