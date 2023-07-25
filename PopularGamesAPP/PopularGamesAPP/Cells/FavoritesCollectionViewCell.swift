//
//  FavoritesCollectionViewCell.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit
import GamesAPI
class FavoritesCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FavoritesCollectionViewCell"
    public let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    public let gameNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Game Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    public let ratesLabel: UILabel = {
       let label = UILabel()
        label.text = "Game Rate"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    public var fullStackView: UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FavoritesCollectionViewCell{
    private func style(){
        fullStackView = UIStackView(arrangedSubviews: [gameImageView, gameNameLabel,ratesLabel])
        fullStackView.axis = .vertical
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(fullStackView)
        NSLayoutConstraint.activate([
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
            
            fullStackView.topAnchor.constraint(equalTo: topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func configure(with game: Games) {
        if let imageData = Data(base64Encoded: game.backgroundImage!) {
            if let image = UIImage(data: imageData) {
                gameImageView.image = image
            } else {
                
                gameImageView.image = UIImage(named: "loading")
            }
        } else {
           
            gameImageView.image = UIImage(named: "loading")
        }

        gameNameLabel.text = game.name
        ratesLabel.text = game.released
    }

}
