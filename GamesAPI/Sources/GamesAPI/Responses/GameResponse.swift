//
//  File.swift
//  
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import Foundation

public struct GamesResponse: Decodable {
    public let results: [Games]
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Games].self, forKey: .results)
    }
}
