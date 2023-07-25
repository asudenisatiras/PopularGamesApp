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
public  let id: Int32?
public  let name, released: String?
public  let backgroundImage: String?
public  let rating: Double?
public  let ratingTop: Int?
public  let metacritic: Int?

   public init(id: Int32?, name: String?, released: String?, backgroundImage: String?, rating: Double?, ratingTop: Int?, metacritic: Int?) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.metacritic = metacritic
    }
    
    enum CodingKeys: String, CodingKey {
        case name, released
        case id
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case metacritic
    
    }

}
public struct GamesDetails: Decodable {
    public let name: String?
    public let released: String?
    public let backgroundImage:String?
    public let id: Int32?
    public let rating: Double?
    public let metacritic: Int?
    public let description: String?
    
    enum CodingKeys: String,CodingKey {
        case name
        case released
        case backgroundImage = "background_image"
        case id
        case rating
        case metacritic
        case description = "description_raw"//<p> kalkıyo!!
    }
}

