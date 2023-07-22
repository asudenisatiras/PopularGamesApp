//
//  MockHomeViewModel.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 22.07.2023.
//

import Foundation
import XCTest
import GamesAPI
@testable import PopularGamesAPP

//final class MockHomeViewModel: HomeViewModelProtocol {
//
//    var view: PopularGamesAPP.HomeViewModelProtocol!
//
//    func getFirstThreeGames() -> [Games] {
//        isInvokegetFirstThreeGames = true
//        invokegetFirstThreeGamessCount += 1
//        return []
//    }
//
//    var invokedgetGameParameters: (index: Int, Void)?
////    func getGame(index: Int) -> Games {
////        isInvokegetGame = true
////        invokegetgetGameCount += 1
////        return Games(from: <#T##Decoder#>)
////    }
//
//
//
//
//
//    var gamesCount: Int = 0
//
//    var games: [Games] = []
//
//    var pageViewControllerGameCount: Int = 0
//
//    var isHeaderHidden: Bool = false
//
//    var delegate: PopularGamesAPP.HomeViewModelDelegate?
//
//    var isInvokedgamesListDownloadFinished = false
//    var invokedgamesListDownloadFinishedCount = 0
//
//    var isInvokeddetailDownloadFinished = false
//    var invokeddetailDownloadFinishedCount = 0
//
//    var isInvokedfetchGames = false
//    var invokedfetchGamesCount = 0
//
//    var isInvokedfetchGameDetails = false
//    var invokedfetchGameDetailsCount = 0
//
//    var isInvokedownloadGames = false
//    var invokedownloadGamesCount = 0
//
//    var isInvokegetFirstThreeGames = false
//    var invokegetFirstThreeGamessCount = 0
//
//    var isInvokegetGame = false
//    var invokegetgetGameCount = 0
//
//
//    func gamesListDownloadFinished(){
//        isInvokedgamesListDownloadFinished = true
//        invokedgamesListDownloadFinishedCount += 1
//    }
//    func detailDownloadFinished(){
//        isInvokeddetailDownloadFinished = true
//        invokeddetailDownloadFinishedCount += 1
//    }
//
//    func fetchGames(_ searchText: String?){
//        isInvokedfetchGames = true
//        invokedfetchGamesCount += 1
//    }
//
//    func fetchGameDetails(index: Int, isPageControl: Bool){
//        isInvokedfetchGameDetails = true
//        invokedfetchGameDetailsCount += 1
//    }
//    func downloadGames(_ searchText: String?){
//        isInvokedownloadGames = true
//        invokedownloadGamesCount += 1
//    }
//}
