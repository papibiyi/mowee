//
//  DetailViewController.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    let contentView = DetailsView()
    let viewModel = DetailsViewModel()
    var favouriteMovies: [Movie]? {
        return MoviePersisterManager.shared.load()
    }
    
    var movie: Movie? {
        didSet {
            setupFavouriteButton()
        }
    }
    
    init(with data: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = data
        contentView.configureView(with: data)
        getMovieDetails(by: data.id ?? 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        setupCustomView()
        setupButtonActionForFavouriteButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupFavouriteButton() {
        guard let favouriteMovies = favouriteMovies else { return }
        if favouriteMovies.contains(where: { (data) -> Bool in
            guard let movie = movie else {return false}
            return data.id == movie.id
        }) {
            contentView.favouriteLabel.backgroundColor = UIColor.yellow
        }else {
            contentView.favouriteLabel.backgroundColor = UIColor.darkGray
        }
    }
    
    private func getMovieDetails(by id: Int) {
        viewModel.getMovieDetail(id: id) { (result) in
            switch result {
            case .success(let movie):
                guard let movie = movie else { return }
                DispatchQueue.main.async {
                    self.movie = movie
                    self.contentView.configureView(with: movie)
                }
            default:
                break
            }
        }
    }
    
    @objc private func onFavouriteLabelTapped() {
        guard let movie = movie else { return }
        guard let favouriteMovies = favouriteMovies else { return }
        if favouriteMovies.contains(where: { (data) -> Bool in
            return data.id == movie.id
        }) {
            MoviePersisterManager.shared.remove(movie: movie)
        }else {
            MoviePersisterManager.shared.save(movie: movie)
        }

        
        setupFavouriteButton()
    }
    
    private func setupButtonActionForFavouriteButton() {
        contentView.favouriteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavouriteLabelTapped)))
    }
    
    private func setupCustomView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
