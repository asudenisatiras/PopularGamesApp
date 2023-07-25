//
//  DetailsTests.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 25.07.2023.
//

import Foundation
@testable import PopularGamesAPP
import XCTest

class DetailsTests : XCTestCase {
    var viewModel: DetailsViewModelProtocol!
    var isInvokeddetailDownloadFinished = false
    var isInvokeddetailDownloadFinishedCount = 0
    
    var isInvokedimageDownloadFinished = false
    var isInvokedimageDownloadFinishedCount = 0
    override func setUp() {
        viewModel = DetailsViewModel(gamesId: 12, service: MockServiceAPI())
        viewModel.delegate = self
    }
    
    func testFetchGameDetails(){
        XCTAssertNotNil(viewModel.gameName)
        XCTAssertNotNil(viewModel.metacriticRate)
        XCTAssertNotNil(viewModel.releasedDate)
        XCTAssertNotNil(viewModel.description)
        XCTAssertNotNil(viewModel.gameId)
        XCTAssertFalse(isInvokeddetailDownloadFinished)
        XCTAssertEqual(isInvokeddetailDownloadFinishedCount, 0)
        viewModel.fetchGameDetails(gamesId: 12)
        XCTAssertTrue(isInvokeddetailDownloadFinished)
        XCTAssertEqual(isInvokeddetailDownloadFinishedCount, 1)
        
        
       
    }
}
extension DetailsTests:DetailsViewModelDelegate{
    
    func detailDownloadFinished() {
        isInvokeddetailDownloadFinished = true
        isInvokeddetailDownloadFinishedCount += 1
    }
    
    func imageDownloadFinished(data: Data) {
        isInvokedimageDownloadFinished = true
        isInvokedimageDownloadFinishedCount += 1
    }
    
    
}
