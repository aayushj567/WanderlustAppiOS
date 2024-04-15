//
//  ItineraryView.swift
//  WanderlustAppiOS
//
//  Created by Aneesh kumar B on 4/15/24.
//

import UIKit

class ItineraryView: UIView {
    
    var tableView: UITableView!
    var startDatePicker: UIDatePicker!
    var endDatePicker: UIDatePicker!
    var saveButton: UIButton!
    var tabBarView: UIView!
    var planNameLabel: UILabel!
    
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
        planNameLabel.text = "Your Plan Name"
        planNameLabel.textAlignment = .center
        planNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        planNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 5
        
        setupTabBarView()
        
        addSubview(planNameLabel)
        addSubview(saveButton)
        addSubview(tableView)
        addSubview(startDatePicker)
        addSubview(endDatePicker)
        addSubview(saveButton)
        
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
            iconImageView.tag = index
            stackView.addArrangedSubview(iconImageView)
        }
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            planNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            planNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            startDatePicker.topAnchor.constraint(equalTo: planNameLabel.bottomAnchor, constant: 20),
            startDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
            endDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -8),
            
            tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
