//
//  HomeViewController.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    let contentView = HomeView()
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        
        viewModel.getNowPlaying { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.contentView.nowPlayingView.inject(data: movies)
                }
            default:
                break
            }
        }
        
        viewModel.getPopularMovies { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.contentView.popularMoviesView.inject(data: movies)
                }
            default:
                break
            }
        }
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
