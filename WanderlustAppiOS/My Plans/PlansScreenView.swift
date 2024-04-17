//
//  FirstScreenView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class PlanScreenView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var tableViewExpense: UITableView!
    var tabBarView: UIView!
    var onIconTapped: ((Int) -> Void)?
        

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white

            setupTableViewExpense()
            setupTabBarView()
            initConstraints()
        }
        
        func setupTableViewExpense(){
            tableViewExpense = UITableView()
            tableViewExpense.separatorStyle = .none
            tableViewExpense.layer.borderColor = UIColor.white.cgColor
            tableViewExpense.separatorColor = .white
            tableViewExpense.layer.borderColor = .none
            tableViewExpense.register(TableViewPlansCell.self, forCellReuseIdentifier: "plans")
            tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableViewExpense)
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
                tableViewExpense.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
                tableViewExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                tableViewExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                tabBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
