//
//  AddGuestsView.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddGuestsView: UIView {
    var searchBar: UISearchBar!
    var tableViewPeople: UITableView!
    var buttonNext: UIButton!
    var tabBarView: UIView!
    var onIconTapped: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSearchBar()
        setupTableViewContacts()
        setupNextButton()
        setupTabBarView()
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
    
    func setupNextButton() {
        buttonNext = UIButton(type: .system)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.setTitle("Next", for: .normal)
        buttonNext.setTitleColor(.white, for: .normal)
        buttonNext.backgroundColor = .systemBlue
        buttonNext.layer.cornerRadius = 5
        self.addSubview(buttonNext)
    }
    
    func setupTabBarView() {
        tabBarView = UIView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tabBarView)
        
        // Create a stack view for the icons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually // This will distribute the space equally among the icons
        stackView.alignment = .center
        stackView.axis = .horizontal
        tabBarView.addSubview(stackView)
        
        // Add constraints to the stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor)
        ])
        
        // Initialize icon views and add them to the stack view
        let iconNames = ["house", "list.bullet", "message", "person.crop.circle"]
        for (index, iconName) in iconNames.enumerated() {
            let iconImageView = UIImageView(image: UIImage(systemName: iconName))
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.isUserInteractionEnabled = true
            iconImageView.tag = index  // Set the tag to the index of the iconName
            
            // Add a gesture recognizer to each icon
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
            iconImageView.addGestureRecognizer(tapGesture)
            
            stackView.addArrangedSubview(iconImageView)
        }
    }
    
    @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
                guard let iconView = sender.view else { return }
                let index = iconView.tag
                // The view controller that holds this view will set this closure to handle the icon tap.
                onIconTapped?(index)
            }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewPeople.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableViewPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewPeople.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableViewPeople.bottomAnchor.constraint(equalTo: buttonNext.topAnchor, constant: -16),
                    
            buttonNext.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonNext.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonNext.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            buttonNext.heightAnchor.constraint(equalToConstant: 50),
            
            tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


