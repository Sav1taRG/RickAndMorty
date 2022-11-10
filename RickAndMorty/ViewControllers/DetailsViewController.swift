//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Roman Golubinko on 10.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var characterImg: UIImageView!
    @IBOutlet var characterInfoLb: UILabel!
   
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character?.name
        fetchImage()
        characterInfoLb.text = character?.info
        characterImg.layer.cornerRadius = characterImg.frame.width / 2
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: self.character?.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImg.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
