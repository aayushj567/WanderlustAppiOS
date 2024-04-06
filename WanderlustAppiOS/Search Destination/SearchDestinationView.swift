//
//  SearchDestinationView.swift
//
//
//  Created by Anwesa Basu on 27/03/24.
//

import UIKit

class SearchDestinationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var nextButton: UIButton!
    var tabBarView: UIView!
    var contentWrapper:UIScrollView!
    var onIconTapped: ((Int) -> Void)?
    
    //MARK: View initializer...
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setting the background color...
        self.backgroundColor = .white
       setupContentWrapper()
       setupSearchBar()
        setupTableView()
        setupNextButton()
        setupTabBarView()
        initConstraints()
    }
    
    func initConstraints()
    {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                    contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                    contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
                    contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
                    tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                    tabBarView.heightAnchor.constraint(equalToConstant: 50)
                ])
       
        NSLayoutConstraint.activate([
                       searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                       searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                       searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                       
                       tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
                       
                       tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                       tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
                       tableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -8),
                       
                       nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                       nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                       nextButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
                       nextButton.heightAnchor.constraint(equalToConstant: 50)
                       
                     
                ])
       

              
            
    }
    
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        //contentWrapper.contentSize = CGSize(width: 400, height: 2300)
        self.addSubview(contentWrapper)
        
    }
    
    func setupNextButton()
    {
        nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = .systemBlue // Example color
        nextButton.layer.cornerRadius = 5
        self.addSubview(nextButton)
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
        let iconNames = ["magnifyingglass", "list.bullet", "message", "person.crop.circle"]
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
        
        // This closure can be set by the view controller to handle tab bar icon taps.
       
    func setupSearchBar()
    {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
    }
    
    func setupTableView(){
        tableView = UITableView()
        tableView.register(DestinationTableViewCell.self, forCellReuseIdentifier: "destinations")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
    }
    
   
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
