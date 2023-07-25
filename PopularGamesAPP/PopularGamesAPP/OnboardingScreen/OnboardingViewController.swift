//
//  OnboardingViewController.swift
//  PopularGamesAPP
//
//  Created by Asude Nisa Tıraş on 24.07.2023.
//
import UIKit

class OnboardingViewController: UIViewController {

    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var nextBtn: UIButton!
    private var currentPage = 0
    private let sentences = [
        "We are here to ensure you have a comfortable travel experience while traveling at the best prices.",
        "Plan ahead and enjoy the journey using our bus ticketing app!",
        "Enjoy a comfortable journey by purchasing your tickets at the most affordable prices."
    ]
    private let images = ["AppIcon", "appName", "loading"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        view.addSubview(scrollView)

        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = sentences.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        view.addSubview(pageControl)

        nextBtn = UIButton()
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(nextBtn)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),

            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextBtn.topAnchor),

            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nextBtn.heightAnchor.constraint(equalToConstant: 50)
        ])

        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(sentences.count), height: scrollView.frame.size.height)

        for i in 0..<sentences.count {
            let screen = UIView()
            screen.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(screen)

            let imageInformations = UILabel()
            imageInformations.translatesAutoresizingMaskIntoConstraints = false
            imageInformations.textAlignment = .center
            imageInformations.numberOfLines = 3
            imageInformations.text = sentences[i]
            screen.addSubview(imageInformations)

            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(named: images[i])
            image.contentMode = .scaleAspectFit
            screen.addSubview(image)

            NSLayoutConstraint.activate([
                screen.topAnchor.constraint(equalTo: scrollView.topAnchor),
                screen.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(i) * view.frame.size.width),
                screen.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                screen.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

                image.topAnchor.constraint(equalTo: screen.topAnchor),
                image.leadingAnchor.constraint(equalTo: screen.leadingAnchor),
                image.trailingAnchor.constraint(equalTo: screen.trailingAnchor),
                image.bottomAnchor.constraint(equalTo: screen.bottomAnchor),

                imageInformations.leadingAnchor.constraint(equalTo: screen.leadingAnchor, constant: 10),
                imageInformations.trailingAnchor.constraint(equalTo: screen.trailingAnchor, constant: -10),
                imageInformations.bottomAnchor.constraint(equalTo: screen.bottomAnchor, constant: -10),
                imageInformations.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }

    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }

    @objc private func nextButtonTapped(_ sender: UIButton) {
        currentPage = pageControl.currentPage
        if currentPage < pageControl.numberOfPages - 1 {
            currentPage += 1
            scrollView.setContentOffset(CGPoint(x: CGFloat(currentPage) * view.frame.size.width, y: 0), animated: true)
            pageControl.currentPage = currentPage
            nextBtn.setTitle(currentPage == pageControl.numberOfPages - 1 ? "Get Started" : "Next", for: .normal)
        } else {
            // Transition to MainTabBarController
            let mainTabBarController = MainTabBarController() // Replace MainTabBarController() with the actual initialization of your MainTabBarController if you have one.
            mainTabBarController.modalPresentationStyle = .fullScreen
            present(mainTabBarController, animated: true, completion: nil)
        }
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        pageControl.currentPage = currentPage
        nextBtn.setTitle(currentPage == pageControl.numberOfPages - 1 ? "Get Started" : "Next", for: .normal)
    }
}

