//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 10.11.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    // MARK: Private Properties
    private var apiResponse: APIResponse?
    
    // MARK: VC Lifecycle Methods
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
    // MARK: IB Actions
    @IBAction func navButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            // Next button
            guard let nextUrl = apiResponse?.info.next else {
                print("No more pages to load. Current API response: \(String(describing: apiResponse))")
                return
            }
            print("Navigating to Next page: \(nextUrl)")
            fetchData(from: nextUrl)
        } else {
            // Prev button
            guard let prevUrl = apiResponse?.info.prev else {
                print("This is the first page. Current API response: \(String(describing: apiResponse))")
                return
            }
            print("Navigating to Previous page: \(prevUrl)")
            fetchData(from: prevUrl)
        }
    }
    
    // MARK: Networking
    private func fetchData(from url: String?) {
        guard let urlString = url else {
            print("Invalid URL.")
            return
        }
        
        NetworkManager.shared.fetch(APIResponse.self, from: urlString) { [weak self] result in
            switch result {
            case .success(let apiResponse):
                print("API Response received: \(apiResponse)")
                self?.apiResponse = apiResponse
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let character = apiResponse?.results[indexPath.row]
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.character = character
        
    }
}
