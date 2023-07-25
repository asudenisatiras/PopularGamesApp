//
//  PageViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 17.07.2023.
//

import UIKit

class PageViewController: UIViewController{
    
    var gameImage: UIImage? {
        didSet {
            gamesImage.image = gameImage
        }
    }
    
    var gameName: String? {
        didSet {
            nameOfGameLabel.text = gameName
        }
    }
    
    public var gamesImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    public var nameOfGameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of Game"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}
extension PageViewController {
    private func setup(){
        view.addSubview(gamesImage)
        view.addSubview(nameOfGameLabel)
        gamesImage.translatesAutoresizingMaskIntoConstraints = false
        nameOfGameLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            gamesImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gamesImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gamesImage.widthAnchor.constraint(equalToConstant: 100), 
            gamesImage.heightAnchor.constraint(equalToConstant: 200),
            gamesImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gamesImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameOfGameLabel.topAnchor.constraint(equalTo: gamesImage.bottomAnchor, constant: -32),
            nameOfGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameOfGameLabel.leadingAnchor.constraint(equalTo: gamesImage.leadingAnchor)
        ])
    }
}


