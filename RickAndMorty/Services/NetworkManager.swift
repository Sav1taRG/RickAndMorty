//
//  Networking.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 08.11.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, with comletion:
                             @escaping(Result<T, NetworkError>) -> Void) {
        guard let apiUrl = url, let url = URL(string: apiUrl) else {
            comletion(.failure(.brokenURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                comletion(.failure(.noData))
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    comletion(.success(type))
                }
            } catch {
                comletion(.failure(.failedToParse))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { completion(.failure(.failedToParse)) }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    //    func fetch<T: Decodable>() {
    //        guard let url = URL(string: charactersDataUrl) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { data, _, error in
    //            guard let data = data else {
    //                print(error?.localizedDescription ?? "No error description")
    //                return
    //            }
    //            do {
    //                let characters = try JSONDecoder().decode(APIResponse.self, from: data)
    //                print(characters)
    //            } catch let error {
    //                print(error)
    //            }
    //        }.resume()
    //    }
    
}


enum NetworkError: Error {
    case brokenURL
    case noData
    case failedToParse
}
