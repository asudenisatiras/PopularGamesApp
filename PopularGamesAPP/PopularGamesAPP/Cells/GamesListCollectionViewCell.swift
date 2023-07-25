//
//  GamesListCollectionViewCell.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit

class GamesListCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GamesListCollectionViewCell"
    
    var viewModel: GamesListCellViewModelProtocol! {
        didSet{
            viewModel.delegate = self
            viewModel.downloadImage()
            configure()
        }
    }
    
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
        imageView.image = UIImage(named: "star")
        return imageView
    }()
    public let gameNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    public let ratesLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Rate"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    public let releasedDate: UILabel = {
        let label = UILabel()
        label.text = "Released Date"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private var fullStackView: UIStackView!
    private var horizontalStackView: UIStackView!
    private var ratesStackView: UIStackView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            gameImageView.image = UIImage(named: "loading")
        }
    }
}
extension GamesListCollectionViewCell{
    private func style(){
        ratesStackView = UIStackView(arrangedSubviews: [ratesImageView, ratesLabel])
        ratesStackView.axis = .horizontal
        ratesStackView.spacing = 4
        ratesStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView = UIStackView(arrangedSubviews: [gameNameLabel,ratesStackView,releasedDate])
        fullStackView.axis = .vertical
        fullStackView.spacing = 10
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        ratesLabel.translatesAutoresizingMaskIntoConstraints = false
        releasedDate.translatesAutoresizingMaskIntoConstraints = false
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 12
        
        gameImageView.layer.borderColor = UIColor.gray.cgColor
        gameImageView.layer.borderWidth = 1.0
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
            gameImageView.widthAnchor.constraint(equalToConstant: 100),
            gameImageView.heightAnchor.constraint(equalToConstant: 80),
            gameImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5), 
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            fullStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8),
            ratesImageView.heightAnchor.constraint(equalToConstant: 25),
            ratesImageView.widthAnchor.constraint(equalToConstant: 20),
            ratesStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 5)
        ])
    }
    
    func configure() {
        gameNameLabel.text = viewModel.gameName
        ratesLabel.text = viewModel.ratingText
        releasedDate.text = viewModel.releaseDateText
    }
    
    
}
extension GamesListCollectionViewCell : GamesListCellViewModelDelegate {
    func imageDidDownload(_ data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.gameImageView.image = UIImage(data: data)
        }
    }
    
    
}
