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
    
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: VC Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character?.name
        characterInfoLb.text = character.info
        characterImg.layer.cornerRadius = characterImg.frame.width / 2
        showSpinner(in: characterImg)
        fetchImage()
    }
    
    // MARK: Private Properties
    
    private func showSpinner(in view: UIView) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
    }
    
    // MARK: Networking
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: self.character.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImg.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
