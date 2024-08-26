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
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String?, with completion:
                             @escaping(Result<T, NetworkError>) -> Void) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            completion(.failure(.brokenURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.failedToGetData))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.failedToGetData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

enum NetworkError: Error {
    case brokenURL
    case noData
    case failedToGetData
}
