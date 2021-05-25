//
//  DetailsView.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit

class DetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView(with data: Movie) {
        yearLabel.text = "(\(String(data.releaseDate.prefix(4))))"
        titleLabel.text = data.originalTitle
        summaryLabel.text = data.overview
        ratingLabel.text = String(data.voteAverage)
        genreLabel.text = data.genres?.compactMap({ (data) -> String? in
            return data.name
        }).joined(separator: ", ")
        
        ImageCacheManager.fetchImageData(from: "https://image.tmdb.org/t/p/original\(data.backdropPath)") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: data as Data)
            }
        }
        
    }
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 4
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .yellow
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratingsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.borderWidth = 1
        
        var hStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(ratingImage)
            stackView.addArrangedSubview(ratingLabel)
            return stackView
        }()
        
        
        view.addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        hStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let favouriteLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.text = " Favourite "
        label.font = UIFont.systemFont(ofSize: 14, weight: .black)
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(cellImageView)
        stackView.addArrangedSubview(hStackView1)
        stackView.addArrangedSubview(hStackView2)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(summaryLabel)
        return stackView
    }()
    
    private lazy var hStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(yearLabel)
        return stackView
    }()
    
    private lazy var hStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(ratingsView)
        stackView.addArrangedSubview(favouriteLabel)
        stackView.addArrangedSubview(UIView())
        return stackView
    }()
        
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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

        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true

    }

}
