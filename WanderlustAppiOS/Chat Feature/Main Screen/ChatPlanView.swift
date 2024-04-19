//
//  ChatPlanView.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/15/24.
//

import UIKit

class ChatPlanView: UIView {
    var tableView: UITableView!
    var tabBarView: UIView!
        var onIconTapped: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupTableView()
        setupTabBarView()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(){
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.register(ChatPlanTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatPlan)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
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
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            //tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
//            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            tableViewPeople.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
//            tableViewPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            tableViewPeople.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            tableViewPeople.bottomAnchor.constraint(equalTo: buttonNext.topAnchor, constant: 32),
//            
//            buttonNext.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
//            buttonNext.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -8),
                        
                        tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                        tabBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
