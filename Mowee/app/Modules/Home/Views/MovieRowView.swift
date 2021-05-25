//
//  MovieRowView.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit

class MovieRowView: UIView {
    
    var data = [Movie]()
    var collectionViewHeightConstraint: NSLayoutConstraint?
    var onMovieCellTapped: ((Movie) -> Void)?

    let height = CGFloat(300)
    
    init(title: String) {
        self.title.text = title
        super.init(frame: .zero)
        setupView()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private var title: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint?.isActive = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieRowCollectionViewCell.self, forCellWithReuseIdentifier: MovieRowCollectionViewCell.id)
        return collectionView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(collectionView)
        return stackView
    }()
    
    func inject(data: [Movie]) {
        self.data = data
        self.collectionView.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.collectionViewHeightConstraint?.constant = self.height
            self.title.alpha = 1
        }
    }
        
    private func setupView() {
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension MovieRowView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRowCollectionViewCell.id, for: indexPath) as? MovieRowCollectionViewCell
        cell?.configure(with: data)
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((Int(self.collectionView.frame.width - 10) / 2)), height: Int(height))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.data[indexPath.row]
        onMovieCellTapped?(data)
    }
}
