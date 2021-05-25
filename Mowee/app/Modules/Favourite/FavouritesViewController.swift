//
//  FavouritesViewController.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import UIKit

class FavouritesViewController: UIViewController {
    let contentView = FavouriteView()
    
    var favouriteMovies: [Movie] {
        return MoviePersisterManager.shared.load() ?? []
    }
    
    var filteredMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourites"
        setupCustomView()
        setupTableView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentView.tableView.reloadData()
    }
    
    private func setupTableView() {
        contentView.searchBar.delegate = self
    }
    
    private func setupSearchBar() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
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

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = favouriteMovies.filter{($0.title?.lowercased() ?? "").contains(searchBar.text?.lowercased() ?? "")}
        contentView.tableView.reloadData()
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies.count : filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies[indexPath.row].title : filteredMovies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies[indexPath.row] : filteredMovies[indexPath.row]
        let vc = DetailViewController(with: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
