//
//  File.swift
//  
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//


import Foundation

enum Constants: String {
    case baseURL = "https://api.rawg.io"
    case APIKey = "b387453531604408806214bba423c644" 
}

// MARK: Protocol
public protocol GamesServiceProtocol: AnyObject {
    func fetchGames(completion: @escaping (Result<[Games], Error>) -> Void)
    func fetchGameDetails(with id: Int, completion: @escaping (Result<GamesDetails, Error>) -> Void)
}

public class GamesService: GamesServiceProtocol {
    public init() {}
    
    // MARK: Fetch Games
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
            
            let decoder = JSONDecoder()
            
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
        public func searchGames(with query: String, completion: @escaping (Result<[Games], Error>) -> Void) {
            let baseURL = Constants.baseURL.rawValue
            let apiKey = Constants.APIKey.rawValue
            let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
            let urlString = baseURL + "/api/games?key=" + apiKey + "&search=" + query
    
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
    // MARK: Fetch Game Details
    public func fetchGameDetails(with id: Int, completion: @escaping (Result<GamesDetails, Error>) -> Void) {
        let urlString = Constants.baseURL.rawValue + "/api/games/\(id)?key=" + Constants.APIKey.rawValue
        
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
            
            let decoder = JSONDecoder()
            
            do {
                    let response = try decoder.decode(GamesDetails.self, from: data)
                    completion(.success(response))
                } catch {
                    print("********** JSON DECODE ERROR *******")
                    completion(.failure(error))
                }
        }
        
        task.resume()
    }
}
