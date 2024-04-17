//
//  AddGuestsView.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/5/24.
//

import UIKit

class AddGuestsView: UIView {
    var searchBar: UISearchBar!
    var tableViewPeople: UITableView!
    var buttonNext: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSearchBar()
        setupTableViewContacts()
        setupNextButton()
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
    
    func setupTableViewContacts(){
        tableViewPeople = UITableView()
        tableViewPeople.register(AddPeopleTableViewCell.self, forCellReuseIdentifier: "addGuestPeople")
        tableViewPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewPeople)
    }
    
    func setupNextButton(){
        buttonNext = UIButton(type: .system)
        buttonNext.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonNext.setTitle("  Next  ", for: .normal)
        buttonNext.backgroundColor = #colorLiteral(red: 0.1844881177, green: 0.4828699231, blue: 1, alpha: 1)
        buttonNext.layer.cornerRadius = 5.0
        buttonNext.setTitleColor(UIColor.white, for: .normal)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonNext)
    }
    func initConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewPeople.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableViewPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewPeople.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableViewPeople.bottomAnchor.constraint(equalTo: buttonNext.topAnchor, constant: 32),
            
            buttonNext.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            buttonNext.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}


