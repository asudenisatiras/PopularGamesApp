//
//  HomeTests.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 22.07.2023.
//

import Foundation
@testable import PopularGamesAPP
import XCTest

class HomeTests : XCTestCase {
    var viewModel: HomeViewModelProtocol!
    
    override func setUp() {
        viewModel = HomeViewModel(service:MockServiceAPI()) //dependency variable: servis oluyor. classle değiştirdik artık hep servise gitmek zorunda kalmıyoruz.
        
        
    }
    func testFetchGames(){
        XCTAssertTrue(viewModel.games.isEmpty)
        viewModel.downloadGames(nil)
        
        XCTAssertTrue(viewModel.gamesCount > 0)
        XCTAssertTrue(viewModel.pageViewControllerGameCount > 0)
        viewModel.fetchGames("aa")
        XCTAssertFalse(viewModel.isHeaderHidden)
        viewModel.fetchGames("aaa")
        XCTAssertTrue(viewModel.isHeaderHidden)
        viewModel.fetchGames("aa")
        XCTAssertFalse(viewModel.isHeaderHidden)
       
    }
   
    
}
