//
//  NowPlayingView.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 24/05/2021.
//

import UIKit

class NowPlayingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with data: Movie) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "https://image.tmdb.org/t/p/original\(data.backdropPath)") else {return}
            guard let ddata = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.imageView.alpha = 0
                self.title.alpha = 0
                UIView.animate(withDuration: 0.4) {
                    self.imageView.image = UIImage(data: ddata)
                    self.title.text = data.title
                    self.imageView.isHidden = false
                    self.imageView.alpha = 1
                    self.title.alpha = 1
                }
            }
        }

    }
    
    private func setupView() {
        
        imageView.isHidden = true
        
        addSubview(imageView)
        addSubview(title)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        title.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

