//
//  PopularGamesAPPUITests.swift
//  PopularGamesAPPUITests
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import XCTest

final class PopularGamesAPPUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    func testExampleControl(){
        
        let app = XCUIApplication()
        app.launch()
                app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        
        let gamesNavigationBar = app.navigationBars["Games"]
        let loveButton = gamesNavigationBar.buttons["love"]
        loveButton.tap()
        sleep(2)
        app.alerts["Favorilere Eklendi"].scrollViews.otherElements.buttons["Tamam"].tap()
        
        loveButton.tap()
        app.alerts["Favorilerden Çıkarıldı"].scrollViews.otherElements.buttons["Tamam"].tap()
        
        let gamesButton = gamesNavigationBar.buttons["Games"]
        gamesButton.tap()
        app.scrollViews.children(matching: .other).element.children(matching: .other).element.tap()
        gamesButton.tap()
        
        let findPopularGamesSearchField = gamesNavigationBar.searchFields["Find Popular Games..."]
        findPopularGamesSearchField.tap()
        //app.staticTexts["Upps! The game you want to search for could not be found. "].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        gamesButton.tap()
        findPopularGamesSearchField.tap()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
                
        //niye bu şekilde tercih edildi tercih sebebi neden viper?
        
     
//        let app = XCUIApplication()
//        app.launch()
//
//        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
//
//        let gamesNavigationBar = app.navigationBars["Games"]
//        gamesNavigationBar.buttons["love"].tap()
//
//        let favorilereEklendiExpectation = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.alerts["Favorilere Eklendi"], handler: nil)
//        wait(for: [favorilereEklendiExpectation], timeout: 5) // Wait for 5 seconds for the alert to appear.
//
//        app.alerts["Favorilere Eklendi"].scrollViews.otherElements.buttons["Tamam"].tap()
//
//        let gamesButton = gamesNavigationBar.buttons["Games"]
//        gamesButton.tap()
//        app.scrollViews.children(matching: .other).element.children(matching: .other).element.tap()
//        gamesNavigationBar.tap()
//
//        let findPopularGamesSearchField = gamesNavigationBar.searchFields["Find Popular Games..."]
//        findPopularGamesSearchField.tap()
//        app.staticTexts["Upps! The game you want to search for could not be found. "].tap()
//        gamesButton.tap()
//        findPopularGamesSearchField.tap()
//        findPopularGamesSearchField.buttons["Clear text"].tap()
//        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
//        app.navigationBars["Favorites"].buttons["trash"].tap()
    
    }
}
