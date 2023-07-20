//
//  DetailsViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//
//

import UIKit

extension DetailsViewController {
    fileprivate enum Constants {
        static let scrollViewPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let imageHeight: CGFloat = 200
    }
}

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
        label.textColor = .label
        return label
    }()
    public var releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    public var metacriticRate: UILabel = {
        let label = UILabel()
        label.text = "Metacritic Rate"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    public var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"

        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .label
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
        updateFavoriteButton()
       
           }
           private func updateFavoriteButton() {
                 guard let gameid = gameid else { return }
                 let isFavorite = CoreDataManager.shared.isGameIdSaved(gameid)
                 let favoriteBarButton = UIBarButtonItem(image: isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
                 navigationItem.rightBarButtonItem = favoriteBarButton
             }
       
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentHeight: CGFloat = 0
        let contentWidth: CGFloat = view.bounds.inset(by: view.safeAreaInsets).size.width - Constants.scrollViewPadding.left - Constants.scrollViewPadding.right
        
        let calculatedStackHeight = calculateStackViewHeight()
        
        contentHeight += calculatedStackHeight
        
        detailsStackView.frame = .init(
            x: 0,
            y: Constants.imageHeight,
            width: contentWidth,
            height: calculatedStackHeight
        )
        
        contentHeight += detailsStackView.spacing * CGFloat(detailsStackView.arrangedSubviews.count)
        
        contentHeight += Constants.imageHeight
        
        imageView.frame = .init(origin: .zero, size: .init(
            width: contentWidth, height: Constants.imageHeight)
        )
        
        scrollView.contentSize = .init(
            width: contentWidth,
            height: contentHeight
        )
    }
    
    var constraints = [NSLayoutConstraint]()
    private func calculateStackViewHeight() -> CGFloat {
        var result: CGFloat = detailsStackView.spacing * CGFloat(detailsStackView.arrangedSubviews.count-1)
        
        let contentWidth = view.bounds.size.width - Constants.scrollViewPadding.left - Constants.scrollViewPadding.right
        let nameLabelSize = nameOfGameLabel.sizeThatFits(.init(width: contentWidth, height: .zero))
        let releaseLabelSize = releaseDate.sizeThatFits(.init(width: contentWidth, height: .zero))
        let ratingLabelSize = metacriticRate.sizeThatFits(.init(width: contentWidth, height: .zero))
        let descriptionLabelSize = descriptionLabel.sizeThatFits(.init(width: contentWidth, height: .zero))
        
        nameOfGameLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        metacriticRate.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        for constraint in constraints {
            constraint.isActive = false
        }
        
        constraints = [
            nameOfGameLabel.heightAnchor.constraint(equalToConstant: nameLabelSize.height),
            releaseDate.heightAnchor.constraint(equalToConstant: releaseLabelSize.height),
            metacriticRate.heightAnchor.constraint(equalToConstant: ratingLabelSize.height),
            descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabelSize.height)
        ]
        NSLayoutConstraint.activate(constraints)
        
        result += nameLabelSize.height + releaseLabelSize.height + ratingLabelSize.height + descriptionLabelSize.height
        
        return result
    }
 
}
extension DetailsViewController {
    private func setup(){
        view.backgroundColor = .white
     
        imageView.layer.cornerRadius = 12
     
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
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.scrollViewPadding.top
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.scrollViewPadding.left
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.scrollViewPadding.bottom
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Constants.scrollViewPadding.right
            )
        ])
        
    }
    
    private func layout() {

        scrollView.addSubview(imageView)
        
        detailsStackView = UIStackView(arrangedSubviews: [nameOfGameLabel, releaseDate, metacriticRate, descriptionLabel])
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 8
        scrollView.addSubview(detailsStackView)
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
                
                CoreDataManager.shared.removeFavoriteGame(id: Int32(Int(gameid)))
    
                let alert = UIAlertController(title: "Favorilerden Çıkarıldı", message: "Oyun favorilerden çıkarıldı.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
              
                let backgroundImageData = backgroundImage.pngData()?.base64EncodedString() ?? ""
                       CoreDataManager.shared.saveGameData(name: gameName, released: releasedDate, backgroundImage: backgroundImageData, id: gameid)
    
    
                let alert = UIAlertController(title: "Favorilere Eklendi", message: "Oyun favorilere eklendi.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    
           
            let favoriteBarButton = UIBarButtonItem(image: isFavorite ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
            navigationItem.rightBarButtonItem = favoriteBarButton
            updateFavoriteButton()
        }

}
