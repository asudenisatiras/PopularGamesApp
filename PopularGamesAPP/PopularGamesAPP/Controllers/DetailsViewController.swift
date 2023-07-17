//
//  DetailsViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

//import UIKit
//
//class DetailsViewController: UIViewController {
//    public var gameName: String?
//       public var gameImage: UIImage?
//    private var scrollView: UIScrollView!
//       private var contentView: UIView!
//    public var releasedDate:String?
//    public var metacriticR: String?
//    public var detailsL: String?
//    private var imageView: UIImageView = {
//        let image = UIImageView()
//        image.layer.cornerRadius = 12
//        image.clipsToBounds = true
//        image.contentMode = .scaleAspectFill
//        image.backgroundColor = .purple
//        return image
//    }()
//    private var nameOfGameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Name of Game"
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.textColor = .black
//        return label
//    }()
//    private var releaseDate: UILabel = {
//        let label = UILabel()
//        label.text = "Release Date"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//    private var metacriticRate: UILabel = {
//        let label = UILabel()
//        label.text = "Metacritic Rate"
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .black
//        return label
//    }()
//    private var descriptionLabel : UILabel = {
//        let label = UILabel()
//        label.text = "Description"
//
//        label.font = UIFont.boldSystemFont(ofSize: 10)
//        label.textColor = .black
//        label.numberOfLines = 0
//        return label
//    }()
//    private var favoriteButton: UIButton = {
//        let button = UIButton()
//        button.imageView?.image = UIImage(systemName: "heart")
//        return button
//    }()
//
//    private var detailsStackView : UIStackView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      setup()
//      layout()
//
//    }
//
//}
//extension DetailsViewController {
//    private func setup(){
//        view.backgroundColor = .white
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 12
//        nameOfGameLabel.translatesAutoresizingMaskIntoConstraints = false
//                releaseDate.translatesAutoresizingMaskIntoConstraints = false
//                metacriticRate.translatesAutoresizingMaskIntoConstraints = false
//                descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//                favoriteButton.translatesAutoresizingMaskIntoConstraints = false
//        if let gameName = gameName {
//                nameOfGameLabel.text = gameName
//            }
//
//            if let date = releasedDate {
//                releaseDate.text = date
//            }
//        if let metacritic = metacriticR {
//            metacriticRate.text = metacritic
//        }
//        if let gameImage = gameImage {
//            imageView.image = gameImage
//        }
//        if let details = detailsL {
//            descriptionLabel.text = details
//        }
//
//    }
//    private func layout() {
//        view.addSubview(imageView)
//              NSLayoutConstraint.activate([
//                  imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//                  imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                  imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//                  imageView.heightAnchor.constraint(equalToConstant: 200)
//              ])
//
//              detailsStackView = UIStackView(arrangedSubviews: [nameOfGameLabel, releaseDate, metacriticRate, descriptionLabel, favoriteButton])
//              detailsStackView.axis = .vertical
//              detailsStackView.spacing = 8
//              detailsStackView.translatesAutoresizingMaskIntoConstraints = false
//              view.addSubview(detailsStackView)
//
//              NSLayoutConstraint.activate([
//                  detailsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
//                  detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                  detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//              ])
//          }
//
//}
//
import UIKit

class DetailsViewController: UIViewController {
    public var gameName: String?
    public var gameImage: UIImage?
    private var scrollView: UIScrollView!
        private var contentView: UIView!
    public var releasedDate:String?
    public var metacriticR: String?
    public var detailsL: String?
    public var gameid: Int32?
    convenience init(gameImage: UIImage?) {
            self.init()
            self.gameImage = gameImage
        }
    public var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .purple
        return image
    }()
    public var nameOfGameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of Game"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    public var releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    public var metacriticRate: UILabel = {
        let label = UILabel()
        label.text = "Metacritic Rate"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    public var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"

        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    public var favoriteButton: UIButton = {
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
        if let details = detailsL {
            descriptionLabel.text = details
        }
        scrollView = UIScrollView()
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                contentView = UIView()
                contentView.translatesAutoresizingMaskIntoConstraints = false
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
        let favoriteBarButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteBarButton
        
    }
 
    @objc private func favoriteButtonTapped() {
        guard let gameName = gameName,
              let releasedDate = releasedDate,
              let metacriticRate = metacriticR,
              let gameid = gameid,
              let backgroundImage = imageView.image else {
            print("Favorite button: Missing required data")
            return
        }
        
        let isFavorite = CoreDataManager.shared.isGameIdSaved(gameid)
        
        if isFavorite {
            // Remove the game from favorites
            CoreDataManager.shared.removeFavoriteGame(id: Int32(Int(gameid)))
            
            let alert = UIAlertController(title: "Favorilerden Çıkarıldı", message: "Oyun favorilerden çıkarıldı.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Add the game to favorites
            CoreDataManager.shared.saveGameData(name: gameName, released: releasedDate, backgroundImage: backgroundImage.pngData()?.base64EncodedString() ?? "", id: gameid)
            
            let alert = UIAlertController(title: "Favorilere Eklendi", message: "Oyun favorilere eklendi.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}
