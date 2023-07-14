//
//  DetailsViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    public var gameName: String?
       public var gameImage: UIImage?
    private var scrollView: UIScrollView!
       private var contentView: UIView!
    public var releasedDate:String?
    public var metacriticR: String?
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .purple
        return image
    }()
    private var nameOfGameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of Game"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    private var releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private var metacriticRate: UILabel = {
        let label = UILabel()
        label.text = "Metacritic Rate"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"

        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "heart")
        return button
    }()
    
    private var detailsStackView : UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setup()
      layout()
        
    }
 
}
extension DetailsViewController {
    private func setup(){
        view.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        nameOfGameLabel.translatesAutoresizingMaskIntoConstraints = false
                releaseDate.translatesAutoresizingMaskIntoConstraints = false
                metacriticRate.translatesAutoresizingMaskIntoConstraints = false
                descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        if let gameName = gameName {
                nameOfGameLabel.text = gameName
            }

            if let date = releasedDate {
                releaseDate.text = date
            }
        if let metacritic = metacriticR {
            metacriticRate.text = metacritic
        }
        if let gameImage = gameImage {
            imageView.image = gameImage
        }

    }
    private func layout() {
        view.addSubview(imageView)
              NSLayoutConstraint.activate([
                  imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                  imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                  imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                  imageView.heightAnchor.constraint(equalToConstant: 200)
              ])
              
              detailsStackView = UIStackView(arrangedSubviews: [nameOfGameLabel, releaseDate, metacriticRate, descriptionLabel, favoriteButton])
              detailsStackView.axis = .vertical
              detailsStackView.spacing = 8
              detailsStackView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(detailsStackView)
              
              NSLayoutConstraint.activate([
                  detailsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                  detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                  detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
              ])
          }

}

