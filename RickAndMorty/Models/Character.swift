//
//  Character.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 08.11.2022.
//

struct APIResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let created: String
    
    var info: String {
    """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Type: \(type.isEmpty ? "Ordinary": type)
    Gender: \(gender)
    Origin: \(origin.name)
    Location: \(location.name)
    """
    }
}


struct Origin: Decodable {
    let name: String
    let url: String
}

struct Location: Decodable {
    let name: String
    let url: String
}

let apiUrl = "https://rickandmortyapi.com/api/character"
