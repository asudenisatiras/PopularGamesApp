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
    
    var viewModel: DetailsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            
        }
    }
    
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
        label.textColor = .white
        return label
    }()
    public var releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    public var metacriticRate: UILabel = {
        let label = UILabel()
        label.text = "Metacritic Rate"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    public var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"

        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
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
    private func updateFavoriteButton() {
        guard let gameid = viewModel.gameId else { return }
        let isFavorite = CoreDataManager.shared.isGameIdSaved(gameid)
        let favoriteBarButton = UIBarButtonItem(image: isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName:  "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteBarButton
    }
       
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       setupScrollViewContent()
    }
    private func setupScrollViewContent(){
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
        view.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)
     
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
            let cleanDescription = removeHTMLTags(from: details)
            descriptionLabel.text = cleanDescription
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

        let isFavorite = viewModel.isCoreDataSaved()
        

        if isFavorite {
            
           
            self.presentBottomAlert(
                title: "Favorite Updates",
                message: "Do you want this game to be removed from the favorites?",
                okTitle: "Yes",
                cancelTitle: "Cancel",
                okAction: { [weak self] in
                    guard let self else {
                        return }
                    viewModel.removeFavoriteGame()
                    
                    let favoriteBarButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
                    navigationItem.rightBarButtonItem = favoriteBarButton
                    updateFavoriteButton()
                }
            )
        } else {
            let backgroundImageData = imageView.image?.pngData()?.base64EncodedString() ?? ""
           
            self.presentBottomAlert(
                title: "Favorite Updates",
                message: "Do you want this game to be added to your favorites?",
                okTitle: "Yes",
                cancelTitle: "Cancel",
                okAction: {
                    self.viewModel.saveGameData(imageData: backgroundImageData)
                    let favoriteBarButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(self.favoriteButtonTapped))
                    self.navigationItem.rightBarButtonItem = favoriteBarButton
                    self.updateFavoriteButton()
                }
            )
        }
    }

}
extension DetailsViewController {
    
    func presentBottomAlert(title: String, message: String, okTitle: String, cancelTitle: String, okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: NSLocalizedString(okTitle, comment: ""), style: .default) { _ in
            okAction()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString(cancelTitle, comment: ""), style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func removeHTMLTags(from text: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [])
        let range = NSMakeRange(0, text.utf16.count)
        let htmlLessString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        return htmlLessString
    }

}
extension DetailsViewController : DetailsViewModelDelegate {
    func imageDownloadFinished(data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = UIImage(data: data)
        }
    }
    
    func detailDownloadFinished() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            nameOfGameLabel.text = self.viewModel.gameName
            releaseDate.text = self.viewModel.releasedDate
            metacriticRate.text = String(self.viewModel.metacriticRate ?? 0)
            descriptionLabel.text = self.viewModel.description
            setupScrollViewContent()
            updateFavoriteButton()
        }
         
        viewModel.imageDownloadStart()
    }
    
    
}
