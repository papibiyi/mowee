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
    
    init(with data: Movie) {
        super.init(nibName: nil, bundle: nil)
        contentView.configureView(with: data)
        getMovieDetails(by: data.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func getMovieDetails(by id: Int) {
        viewModel.getMovieDetail(id: id) { (result) in
            switch result {
            case .success(let movie):
                guard let movie = movie else { return }
                DispatchQueue.main.async {
                    self.contentView.configureView(with: movie)
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