//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 10.11.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterNameLB: UILabel!
    
    func configure(with character: Character?) {
        characterNameLB.text = character?.name
        
        NetworkManager.shared.fetchImage(from: character?.image) {
            [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImg.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
