//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 10.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet var characterImg: UIImageView!
    @IBOutlet var characterInfoLb: UILabel!
    
    // MARK: Public Properties
    var character: Character!
    
    // MARK: VC Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character?.name
        fetchImage()
        characterInfoLb.text = character.info
        characterImg.layer.cornerRadius = characterImg.frame.width / 2
    }
    
    // MARK: Networking
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: self.character.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImg.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
