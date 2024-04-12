//
//  ItineraryViewController.swift
//  WanderlustAppiOS
//
//  Created by Aneesh kumar B on 4/5/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let planNameTextField = UITextField()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    var tabBarView: UIView!
    var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        saveButton.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
    }
    
    @objc func onNextButtonTapped(){
        
        
        let dummyData: [[String: Any]] = [
            ["date": "2024-04-11", "name": "Day 1", "destinations": ["Destination A", "Destination B", "Destination C"]],
            ["date": "2024-04-12", "name": "Day 2", "destinations": ["Destination X", "Destination Y"]],
            ["date": "2024-04-13", "name": "Day 3", "destinations": ["Destination P", "Destination Q", "Destination R"]],
            // Add more dummy data as needed
        ]
//        let plan1 = Plan(
//            name: "Vacation in Hawaii",
//            dateFrom: "2024-06-01",
//            dateTo: "2024-06-10",
//            days: dummyData,
//            owner: Auth.auth().currentUser?.uid,
//            guests: ["mLDVMRupY1XUGGx3AQHDKaQvtDg1"]
//        )
        let db = Firestore.firestore()
        let daysCollection = db.collection("days")
        let daysArray: [[String: Any]] = [
            [
                "date": "2024-04-11",
                "name": "Day 1",
                "destinations": ["Destination A", "Destination B"]
            ],
            [
                "date": "2024-04-12",
                "name": "Day 2",
                "destinations": ["Destination C", "Destination D"]
            ],
            [
                "date": "2024-04-13",
                "name": "Day 3",
                "destinations": ["Destination E", "Destination F"]
            ]
        ]

        // Loop through the array and upload each dictionary to Firestore
        for dayData in daysArray {
            // Add a new document with a generated ID
            daysCollection.addDocument(data: dayData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: ")
                }
            }
        }
        // Assuming you have a collection reference
        let plansCollection = db.collection("plans")

        // Retrieve the current user
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("No user signed in")
        }

        // Create a sample plan
        let planData: [String: Any] = [
            "name": "Vacation in Hawaii",
            "dateFrom": "2024-06-01",
            "dateTo": "2024-06-10",
            // Convert days array of objects to dictionaries
            "days": dummyData,
            // Assuming you want to store owner's UID
            "owner": currentUser.uid,
            // Assuming you have an array of guest UIDs
            "guests": ["mLDVMRupY1XUGGx3AQHDKaQvtDg1"]
        ]

        // Add the plan to Firebase
        plansCollection.addDocument(data: planData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added ")
            }
        }
        let searchDestController = SearchDestinationController()
        navigationController?.pushViewController(searchDestController, animated: true)
    }
    
    func setupUI() {
        // Navigation Bar Setup
        self.title = "Plan Name"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Plan Name TextField Setup
        planNameTextField.placeholder = "Enter plan name"
        planNameTextField.borderStyle = .roundedRect
        view.addSubview(planNameTextField)
        
        // Start DatePicker Setup
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(startDateChanged(_:)), for: .valueChanged)
        
        // End DatePicker Setup
        endDatePicker.datePickerMode = .date
        endDatePicker.addTarget(self, action: #selector(endDateChanged(_:)), for: .valueChanged)
        
        // Stack View for DatePickers
        let datePickersStackView = UIStackView(arrangedSubviews: [startDatePicker, endDatePicker])
        datePickersStackView.axis = .horizontal
        datePickersStackView.distribution = .fillEqually
        datePickersStackView.spacing = 10
        datePickersStackView.alignment = .center
        view.addSubview(datePickersStackView)
        
        // TableView Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // Add Button Setup
        let addButton = UIButton(type: .system)
        addButton.setTitle("+ Add", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // Estimate Budget Button Setup
        let estimateBudgetButton = UIButton(type: .system)
        estimateBudgetButton.setTitle("Estimate", for: .normal)
        estimateBudgetButton.setTitleColor(.white, for: .normal) // Set title color
        estimateBudgetButton.backgroundColor = .systemBlue
        estimateBudgetButton.layer.cornerRadius = 10

        // Save Button Setup
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal) // Set title color
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        
        // Create a horizontal stack view for the buttons
        let buttonsStackView = UIStackView(arrangedSubviews: [addButton, estimateBudgetButton, saveButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        view.addSubview(buttonsStackView)
        
        // Tab Bar View Setup
        setupTabBarView()
        
        // Auto Layout Constraints
        planNameTextField.translatesAutoresizingMaskIntoConstraints = false
        datePickersStackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            planNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            planNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            planNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            datePickersStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePickersStackView.topAnchor.constraint(equalTo: planNameTextField.bottomAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: datePickersStackView.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func addButtonTapped() {
        // Handle the add button tap
    }
    
    @objc func startDateChanged(_ sender: UIDatePicker) {
        // Handle the start date change
    }
    
    @objc func endDateChanged(_ sender: UIDatePicker) {
        // Handle the end date change
    }
    
    // MARK: - TableView Delegate & DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Add image icon
        let imageIcon = UIImageView(image: UIImage(systemName: "calendar"))
        imageIcon.tintColor = .systemBlue
        cell.contentView.addSubview(imageIcon)
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIcon.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            imageIcon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            imageIcon.widthAnchor.constraint(equalToConstant: 20),
            imageIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // Add label with day text
        let dayLabel = UILabel()
        dayLabel.text = "Day \(indexPath.row + 1)"
        cell.contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            dayLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        // Round cell corners
        cell.layer.cornerRadius = 10.0
        
        // Increase cell height
        cell.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Add spacing between cells
        let spacing = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 10))
        spacing.backgroundColor = .clear
        cell.contentView.addSubview(spacing)
        spacing.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spacing.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            spacing.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            spacing.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            spacing.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        return cell
    }


    
    func setupTabBarView() {
        tabBarView = UIView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        
        // Create a stack view for the icons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
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
            let iconImageView = UIImageView(image: UIImage(systemName: iconName)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal))
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.isUserInteractionEnabled = true
            iconImageView.tag = index
            
            // Add a gesture recognizer to each icon
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
            iconImageView.addGestureRecognizer(tapGesture)
            
            stackView.addArrangedSubview(iconImageView)
        }
        
        // Add constraints for the tab bar view
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
        guard let iconView = sender.view else { return }
        let index = iconView.tag
        // Handle the icon tap based on the index
        print("Icon at index \(index) was tapped.")
            // Handle the icon tap, switch views accordingly
            if(index == 0){
                let homeView = CalendarViewController()
                navigationController?.pushViewController(homeView, animated: true)
            }
            if(index == 1){
                let myplansVC = MyPlansViewController()
                navigationController?.pushViewController(myplansVC, animated: true)
            }
            if(index == 2)
            {
                let chatView = ChatViewController()
                navigationController?.pushViewController(chatView, animated: true)
            }
            print("Icon at index \(index) was tapped.")
            if(index == 3)
            {
                let profileView = ShowProfileViewController()
                navigationController?.pushViewController(profileView, animated: true)
            }
            
            // Insert logic to switch to the corresponding view
    }
}
