//
//  HomeView.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import UIKit

class HomeView: UIView {
    
    var onScrollViewRefreshed = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nowPlayingView = MovieRowView(title: "Now Playing")
    let popularMoviesView = MovieRowView(title: "Popular Movies")

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(scrollViewRefreshed), for: .valueChanged)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    @objc private func scrollViewRefreshed() {
        onScrollViewRefreshed()
    }
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nowPlayingView)
        stackView.addArrangedSubview(popularMoviesView)
        return stackView
    }()


    
    private func setupView() {
        self.backgroundColor = UIColor(named: "background")
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(self.stackView)

        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true

    }

}
