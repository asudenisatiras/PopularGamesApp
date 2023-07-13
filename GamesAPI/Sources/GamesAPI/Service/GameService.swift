//
//  File.swift
//  
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import Foundation

enum Constants: String {
    case baseURL = "https://api.rawg.io"
    case APIKey = "b387453531604408806214bba423c644" // your NYTimes api key here
}
    // MARK: Protocol
public protocol GamesServiceProtocol: AnyObject {
    func fetchGames(completion: @escaping (Result<[Games], Error>) -> Void)
}

public class GamesService: GamesServiceProtocol {
    public init() {}

    // MARK: Fetch Function
    public func fetchGames(completion: @escaping (Result<[Games], Error>) -> Void) {
        let urlString = Constants.baseURL.rawValue + "/api/games?key=" + Constants.APIKey.rawValue

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Invalid Data")
                return
            }

            let decoder = Decoders.dateDecoder

            do {
                let response = try decoder.decode(GamesResponse.self, from: data)

               completion(.success(response.results))

            } catch {
                print("********** JSON DECODE ERROR *******")
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
}

