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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        setupTapAction()
        fetchData()
        setupScrollViewRefresh()
    }
    
    private func fetchData() {
        viewModel.getNowPlaying { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.contentView.nowPlayingView.inject(data: movies)
                    self.contentView.scrollView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
        
        viewModel.getPopularMovies { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.contentView.popularMoviesView.inject(data: movies)
                    self.contentView.scrollView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
    }
    
    private func setupScrollViewRefresh() {
        contentView.onScrollViewRefreshed = {
            self.fetchData()
        }
    }
    
    private func setupTapAction() {
        contentView.nowPlayingView.onMovieCellTapped = {[weak self] data in
            let controller = DetailViewController(with: data)
            self?.navigationController?.pushViewController(controller, animated: true)

        }
        
        contentView.popularMoviesView.onMovieCellTapped = {[weak self] data in
            let controller = DetailViewController(with: data)
            self?.navigationController?.pushViewController(controller, animated: true)
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
