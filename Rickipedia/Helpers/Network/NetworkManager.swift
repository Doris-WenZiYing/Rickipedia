//
//  NetworkManager.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    let baseURL = "https://rickandmortyapi.com/api"
    
    func fetchData<T: Decodable>(endPoint: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/\(endPoint)") else {
            print("Invalid URL: \(baseURL)\(endPoint)")
            completion(.failure(NSError(domain: "InvalidError", code: -1, userInfo: nil)))
            return
        }
        
        print("Fetching: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request Error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                print("No Data Recieved")
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Data"])))
                }
                return
            }
            
            // Decode JSON
            do {
                let decodeResponse = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    print("Successfully Decoded Data: \(decodeResponse)")
                    completion(.success(decodeResponse))
                }
            } catch {
                print("Decoding Error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}
