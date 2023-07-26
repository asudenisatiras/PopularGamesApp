//
//  EmptyFavoritesCollectionViewCell.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 19.07.2023.
//

import UIKit

class EmptyFavoritesCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "addFav"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant:  200),
//            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 200),
//            imageView.widthAnchor.constraint(equalToConstant: 400),
//            imageView.heightAnchor.constraint(equalToConstant: 370),
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100)
//
//
//        ])
//
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 200),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 560),
            imageView.heightAnchor.constraint(equalToConstant: 570)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


