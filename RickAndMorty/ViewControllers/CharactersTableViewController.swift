//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 10.11.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    private var apiResponse: APIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 55
        fetchData(from: apiUrl)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apiResponse?.results.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "characterCell",
            for: indexPath
        )
        guard let cell = cell as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = apiResponse?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetch(APIResponse.self, from: url) { [weak self] result in
            switch result {
            case .success(let apiResponse):
                self?.apiResponse = apiResponse
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
