//
//  GamesListCollectionViewCell.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

//import UIKit
//import GamesAPI
//class GamesListCollectionViewCell: UICollectionViewCell {
//
//
//    public let gameImageView: UIImageView = {
//       let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 12
//        return imageView
//    }()
//    public let gameNameLabel: UILabel = {
//       let label = UILabel()
//        label.text = "Game Name"
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//    public let ratesLabel: UILabel = {
//       let label = UILabel()
//        label.text = "Game Rate"
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textColor = .black
//        return label
//    }()
//    public let releasedDate: UILabel = {
//       let label = UILabel()
//        label.text = "Released Date"
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textColor = .black
//        return label
//    }()
//    private var fullStackView: UIStackView!
//    private var horizontalStackView: UIStackView!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        style()
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//extension GamesListCollectionViewCell{
//    private func style(){
//        fullStackView = UIStackView(arrangedSubviews: [gameNameLabel, ratesLabel, releasedDate])
//        fullStackView.axis = .vertical
//        fullStackView.spacing = 10
//        fullStackView.translatesAutoresizingMaskIntoConstraints = false
//        gameImageView.translatesAutoresizingMaskIntoConstraints = false
//        ratesLabel.translatesAutoresizingMaskIntoConstraints = false
//        releasedDate.translatesAutoresizingMaskIntoConstraints = false
//        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
//      //horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//    }
//    private func layout() {
//        horizontalStackView = UIStackView()
//        horizontalStackView.axis = .horizontal
//        horizontalStackView.spacing = 16
//        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        addSubview(horizontalStackView)
//
//        horizontalStackView.addArrangedSubview(gameImageView)
//        horizontalStackView.addArrangedSubview(fullStackView)
//
//        NSLayoutConstraint.activate([
//            gameImageView.widthAnchor.constraint(equalToConstant: 100), // gameImageView'in belirli bir genişliği olsun
//            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
//
//            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
//            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            fullStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8)
//        ])
//    }
//    func artworkUrl(for games: Games) -> URL? {
//        if let artworkUrlString = games.backgroundImage, let artworkUrl = URL(string: artworkUrlString) {
//            return artworkUrl
//        }
//        return nil
//    }
//
//     func configure(games: Games) {
//        gameNameLabel.text = games.name
//        ratesLabel.text = String(format: "%.1f", games.rating ?? "")
//         releasedDate.text = "Release Date: \(games.released ?? "")"
//         if let artworkUrl = artworkUrl(for: games) {
//             URLSession.shared.dataTask(with: artworkUrl) { (data, response, error) in
//                 if let data = data {
//                     DispatchQueue.main.async {
//                         self.gameImageView.image = UIImage(data: data)
//                     }
//                 }
//             }.resume()
//         }
//     }
//
//
//}
//

import UIKit
import GamesAPI
class GamesListCollectionViewCell: UICollectionViewCell {
    

    public let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    public let ratesImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "rates")
        return imageView
    }()
    public let gameNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Game Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    public let ratesLabel: UILabel = {
       let label = UILabel()
        label.text = "Game Rate"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    public let releasedDate: UILabel = {
       let label = UILabel()
        label.text = "Released Date"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private var fullStackView: UIStackView!
    private var horizontalStackView: UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GamesListCollectionViewCell{
    private func style(){
        fullStackView = UIStackView(arrangedSubviews: [gameNameLabel, ratesLabel, releasedDate])
        fullStackView.axis = .vertical
        fullStackView.spacing = 10
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        ratesLabel.translatesAutoresizingMaskIntoConstraints = false
        releasedDate.translatesAutoresizingMaskIntoConstraints = false
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
      //horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 16
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(gameImageView)
        horizontalStackView.addArrangedSubview(fullStackView)
        
        NSLayoutConstraint.activate([
            gameImageView.widthAnchor.constraint(equalToConstant: 100), // gameImageView'in belirli bir genişliği olsun
            gameImageView.heightAnchor.constraint(equalTo: gameImageView.widthAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fullStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8)
        ])
    }
    func artworkUrl(for games: Games) -> URL? {
        if let artworkUrlString = games.backgroundImage, let artworkUrl = URL(string: artworkUrlString) {
            return artworkUrl
        }
        return nil
    }

     func configure(games: Games) {
        gameNameLabel.text = games.name
        ratesLabel.text = String(format: "%.1f", games.rating ?? "")
         releasedDate.text = "Release Date: \(games.released ?? "")"
         if let artworkUrl = artworkUrl(for: games) {
             URLSession.shared.dataTask(with: artworkUrl) { (data, response, error) in
                 if let data = data {
                     DispatchQueue.main.async {
                         self.gameImageView.image = UIImage(data: data)
                     }
                 }
             }.resume()
         }
     }


}
