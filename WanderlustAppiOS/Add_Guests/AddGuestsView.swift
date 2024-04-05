//
//  AddGuestsView.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/5/24.
//

import UIKit

class AddGuestsView: UIView {
    var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSearchBar()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
        
        // Set the magnifying glass icon
        let searchIcon = UIImage(systemName: "magnifyingglass")
        searchBar.setImage(searchIcon, for: .search, state: .normal)
        searchBar.searchBarStyle = .minimal
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}


