//
//  ItineraryView.swift
//  WanderlustAppiOS
//
//  Created by Aneesh kumar B on 4/15/24.
//

import UIKit

class ItineraryView: UIView {
    
    var tableView: UITableView!
    var startDateInfoLabel: UILabel!
    var endDateInfoLabel: UILabel!
    var saveButton: UIButton!
    var tabBarView: UIView!
    var planNameLabel: UILabel!
    var onIconTapped: ((Int) -> Void)?
    var startDateLabel: UILabel!
    var endDateLabel: UILabel!
    var instructionLabel: UILabel!
    var estimateBudgetButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .white
        
        planNameLabel = UILabel()
        planNameLabel.textAlignment = .center
        planNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        planNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startDateLabel = UILabel()
        startDateLabel.text = "Start Date:"
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.font = UIFont.systemFont(ofSize: 16)
            
        startDateInfoLabel = UILabel()
        startDateInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateInfoLabel.font = UIFont.systemFont(ofSize: 16)
        endDateLabel = UILabel()
        endDateLabel.text = "End Date:"
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.font = UIFont.systemFont(ofSize: 16)
            
        endDateInfoLabel = UILabel()
        endDateInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateInfoLabel.font = UIFont.systemFont(ofSize: 16)
        
        instructionLabel = UILabel()
        instructionLabel.text = "Please select a destination for each day to create your itinerary."
        instructionLabel.numberOfLines = 0
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont.systemFont(ofSize: 16)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
            
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 5
        
        estimateBudgetButton = UIButton()
        estimateBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        estimateBudgetButton.setTitle("Estimate Budget", for: .normal)
        estimateBudgetButton.backgroundColor = .systemGreen
        estimateBudgetButton.layer.cornerRadius = 5
        
        setupTabBarView()
        
               addSubview(planNameLabel)
               addSubview(startDateLabel)
               addSubview(startDateInfoLabel)
               addSubview(endDateLabel)
               addSubview(endDateInfoLabel)
               addSubview(instructionLabel)
               addSubview(saveButton)
               addSubview(tableView)
        addSubview(estimateBudgetButton)
        
        
        applyConstraints()
    }
    
    func setupTabBarView() {
        tabBarView = UIView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tabBarView)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        tabBarView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor)
        ])
        
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
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            planNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                    planNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

                    startDateLabel.topAnchor.constraint(equalTo: planNameLabel.bottomAnchor, constant: 20),
                    startDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

                    startDateInfoLabel.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor),
                    startDateInfoLabel.leadingAnchor.constraint(equalTo: startDateLabel.trailingAnchor, constant: 10),

                    endDateLabel.topAnchor.constraint(equalTo: startDateInfoLabel.bottomAnchor, constant: 20),
                    endDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

                    endDateInfoLabel.centerYAnchor.constraint(equalTo: endDateLabel.centerYAnchor),
                    endDateInfoLabel.leadingAnchor.constraint(equalTo: endDateLabel.trailingAnchor, constant: 10),

                    instructionLabel.topAnchor.constraint(equalTo: endDateInfoLabel.bottomAnchor, constant: 20),
                    instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

                    tableView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
                    tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    saveButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8), // Adjust this
                    saveButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
                    saveButton.heightAnchor.constraint(equalToConstant: 50),
                    
                    estimateBudgetButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 16), // New button
                    estimateBudgetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    estimateBudgetButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
                    estimateBudgetButton.heightAnchor.constraint(equalToConstant: 50),
                    tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                    tabBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
