//
//  MockServisAPI.swift
//  PopularGamesAPPTests
//
//  Created by Asude Nisa Tıraş on 25.07.2023.
//

import Foundation
@testable import GamesAPI
final class MockServiceAPI: GamesServiceProtocol{
    
    var mockGames:[Games] = [
        .init(id: 1,
              name: "A",
              released: "2000",
              backgroundImage: "test",
              rating: 3.6,
              ratingTop: 0,
              metacritic: 100),
        .init(id: 2,
              name: "B",
              released: "1999",
              backgroundImage: "testable",
              rating: 2.8,
              ratingTop: 1,
              metacritic: 96),
        .init(id: 3,
              name: "D",
              released: "1997",
              backgroundImage: "testable",
              rating: 2.8,
              ratingTop: 1,
              metacritic: 96),
        .init(id: 4,
              name: "F",
              released: "1996",
              backgroundImage: "testing",
              rating: 1.6,
              ratingTop: 5,
              metacritic: 80),
        .init(id: 5,
              name: "E",
              released: "1995",
              backgroundImage: "testablee",
              rating: 1.3,
              ratingTop: 2,
              metacritic: 94)
        
    ]
    
    var mockGameDetails: GamesDetails? = .init(
        name: "A",
        released: "2000",
        backgroundImage: "aa",
        id: 12,
        rating: 0.0,
        metacritic: 12,
        description: "aaaa"
    )
    
    func fetchGames(completion: @escaping (Result<[Games], Error>) -> Void) {
        if mockGames.isEmpty{
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockGames))
            print(mockGames)
        }
    }
    
    func fetchGameDetails(with id: Int, completion: @escaping (Result<GamesDetails, Error>) -> Void) {
        if let mockGameDetails, Int(mockGameDetails.id ?? -1) == id {
            completion(.success(mockGameDetails))
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        }
    }
    
    
}


