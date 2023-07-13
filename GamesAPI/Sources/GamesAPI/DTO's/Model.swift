//
//  File.swift
//  
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import Foundation

// MARK: - VideoGame
public struct VideoGames: Decodable {
    public let count: Int?
    public let next: String?
    public let results: [Games]?
    public let description: String?
    //public let filters: Filters?
    
    
}

// MARK: - Result
public struct Games: Decodable {
public  let id: Int?
public  let name, released: String?
public  let backgroundImage: String?
public  let rating: Double?
public  let ratingTop: Int?
public  let metacritic: Int?

    enum CodingKeys: String, CodingKey {
        case name, released
        case id
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case metacritic
    
    }

}


