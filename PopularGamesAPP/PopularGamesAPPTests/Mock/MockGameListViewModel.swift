//
//  MockGameListViewModel.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 22.07.2023.
//

import Foundation
import XCTest
@testable import PopularGamesAPP

var isInvokedartworkURL = false
var invokedartworkURLCount = 0

var isInvokedconfigure = false
var invokedconfigureCount = 0

func artworkURL(){
    isInvokedartworkURL = true
    invokedartworkURLCount += 1
}
func configure(){
    isInvokedconfigure = true
    invokedconfigureCount += 1
}
