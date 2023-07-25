//
//  HomeViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 14.07.2023.
//

import UIKit

protocol HomeViewControllerProtocol{
    func setup()
    func setupPageControlHeight()
    func layout()
    func updateNoDataLabelVisibility()
    func gamesListDownloadFinished()
}

extension HomeViewController {
    fileprivate enum Constants {
        static let pageControllerHeight: CGFloat = 220
        static let pageControlHeight: CGFloat = 25
    }
}

class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate, HomeViewControllerProtocol {
    var pageViewController: UIPageViewController!
    var pages: [UIViewController] = []
    var pageControl: UIPageControl!
    var collectionView: UICollectionView!
    private var noDataLabel: UILabel!
    var pageControllerHeightAnchor: NSLayoutConstraint?
    var pageControlHeightAnchor: NSLayoutConstraint?
    var collectionViewTopToPageControlConstraint: NSLayoutConstraint!
    var isSearchActive = false
    
    private lazy var homeStackView : UIStackView = {
        homeStackView = UIStackView(
            arrangedSubviews: [
                pageViewController.view,
                pageControl,
                collectionView
            ]
        )
        homeStackView.axis = .vertical
        return homeStackView
    }()
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        viewModel.downloadGames(nil)
        pageControllerSetup()
    }
    
    private func createPageViewController(with viewModel: PageViewModel) -> UIViewController {
        let newViewController = PageViewController()
        newViewController.gameName = viewModel.gameName
        
        viewModel.loadGameImage { imageData in
            if let imageData = imageData {
                newViewController.gameImage = UIImage(data: imageData)
            } else {
                newViewController.gameImage = UIImage(named: "loading")
            }
        }
        
        return newViewController
    }
    
}

extension HomeViewController {
    
    func setup(){
        view.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)
        
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.numberOfPages = pages.count
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.register(GamesListCollectionViewCell.self,
                                forCellWithReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.layer.cornerRadius = 12
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        setupPageControlHeight()
        
        collectionView.backgroundColor = UIColor(red: 11/255, green: 4/255, blue: 22/255, alpha: 1.0)
        
        
        view.addSubview(homeStackView)
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        pageViewController.didMove(toParent: self)
        noDataLabel = UILabel()
        noDataLabel.text = "Upps! The game you want to search for could not be found."
        noDataLabel.numberOfLines = 0
        noDataLabel.textColor = .white
        noDataLabel.textAlignment = .center
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noDataLabel)
        
        NSLayoutConstraint.activate([
            noDataLabel.topAnchor.constraint(equalTo: collectionView.topAnchor),
            noDataLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            noDataLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            noDataLabel.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
        
        noDataLabel.isHidden = true
    }
    
    func setupPageControlHeight() {
        pageControllerHeightAnchor = pageViewController.view.heightAnchor.constraint(
            equalToConstant: Constants.pageControllerHeight)
        pageControlHeightAnchor = pageControl.heightAnchor.constraint(
            equalToConstant: Constants.pageControlHeight)
        
        pageControllerHeightAnchor?.isActive = true
        pageControlHeightAnchor?.isActive = true
    }
    
    func layout() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        let textField = searchController.searchBar.searchTextField
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Find Popular Games...", attributes: attributes)
        textField.textColor = .white
        if let glassIconView = textField.leftView as? UIImageView {
            glassIconView.tintColor = .white
        }
    }
}

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first, let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
    
    private func pageControllerSetup() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pageViewControllerTapped))
        pageViewController.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self
    }
    
    @objc private func pageViewControllerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if let currentViewController = pageViewController.viewControllers?.first as? PageViewController {
            if let currentIndex = pages.firstIndex(of: currentViewController) {
                guard let id = viewModel.getGame(index: currentIndex, pageController: true).id else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    let detailsViewController = DetailsViewController()
                    detailsViewController.viewModel = DetailsViewModel(gamesId: Int(id))
                    self?.navigationController?.pushViewController(detailsViewController, animated: true)
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gamesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesListCollectionViewCell.reuseIdentifier, for: indexPath) as! GamesListCollectionViewCell
        cell.backgroundColor = UIColor(red: 31/255, green: 24/255, blue: 40/255, alpha: 1.0)
        
        let games = viewModel.getGame(index: indexPath.row, pageController: false)
        
        let viewModel = GamesListCellViewModel(game: games)
        cell.viewModel = viewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel.getGame(index: indexPath.row, pageController: false).id else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            let detailsViewController = DetailsViewController()
            detailsViewController.viewModel = DetailsViewModel(gamesId: Int(id))
            detailsViewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 48)
        let height: CGFloat = 130
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
}

extension HomeViewController {
    
    func updateNoDataLabelVisibility() {
        if isSearchActive && viewModel.gamesCount == 0 {
            noDataLabel.isHidden = false
        } else {
            noDataLabel.isHidden = true
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = !searchText.isEmpty
        viewModel.fetchGames(searchText)
        pageViewController.view.isHidden = viewModel.isHeaderHidden
        pageControl.isHidden = viewModel.isHeaderHidden
        pageViewController.setViewControllers([pages.first].compactMap { $0 }, direction: .forward, animated: false, completion: nil)
        
        updateNoDataLabelVisibility()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func setupPages(with viewModels: [PageViewModel]) {
        self.pages = viewModels.map { createPageViewController(with: $0) }
        self.pageControl.numberOfPages = self.pages.count
        self.pageViewController.setViewControllers([self.pages.first].compactMap { $0 }, direction: .forward, animated: true, completion: nil)
    }
    
    func gamesListDownloadFinished() {
        let firstThreeGames = viewModel.getFirstThreeGames()
        let pageViewModels = firstThreeGames.map { PageViewModel(game: $0) }
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            setupPages(with: pageViewModels)
            collectionView.reloadData()
            updateNoDataLabelVisibility()
        }
    }
}

