//
//  MovieRowCollectionViewController.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit


class MovieRowCollectionViewCell: UICollectionViewCell {
    static let id = "\(MovieRowCollectionViewCell.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 4
        imageView.heightAnchor.constraint(equalToConstant: self.frame.height - 20 - title.intrinsicContentSize.height).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
    func configure(with data: Movie) {
        self.title.text = data.title
        self.yearLabel.text = String(data.releaseDate.prefix(4))
        self.title.alpha = 0
        self.yearLabel.alpha = 0
        cellImageView.heightAnchor.constraint(equalToConstant: self.frame.height - 20 - title.intrinsicContentSize.height - yearLabel.intrinsicContentSize.height).isActive = true

        ImageCacheManager.fetchImageData(from: "https://image.tmdb.org/t/p/original\(data.posterPath)") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: data as Data)
                self.title.alpha = 1
                self.yearLabel.alpha = 1
            }
        }
    }

    private func setupView() {
        self.contentView.addSubview(cellImageView)
        self.contentView.addSubview(title)
        self.contentView.addSubview(yearLabel)

        cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cellImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        yearLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        yearLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    
}
