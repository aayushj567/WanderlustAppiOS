//
//  ShowContactView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShowPlanDetailsView: UIView {

    var labelName: UILabel!
    var labelDates: UILabel!
    var labelPeople: UILabel!
    var labelTravelPeople: UILabel!
    var labelDayName: UILabel!
    var labelItenerary: UILabel!
    var labelIteneraryData: UILabel!
    var imageView: UIImageView!
    var showPeople: UIButton!
    var deletePlan: UIButton!
    var labelDate: UILabel!
    var tableViewExpense: UITableView!
    var tabBarView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelDate()
        setuplabelDateTo()
        setuplabelTravelPeople()
        setuplabelDayName()
        setupShowPeople()
        setuplabelPeople()
        setupLabelItenerary()
        setupDeletePlan()
        setuplabelIteneraryData()
        setupImage()
        setupTableViewExpense()
        setupTabBarView()
        
        initConstraints()
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.addSubview(labelName)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.textAlignment = .left
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.addSubview(labelDate)
    }
    
    func setuplabelDateTo(){
        labelDates = UILabel()
        labelDates.textAlignment = .left
        labelDates.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDates)
    }
    func setuplabelTravelPeople(){
        labelTravelPeople = UILabel()
        labelTravelPeople.textAlignment = .left
        labelTravelPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTravelPeople)
    }
    func setuplabelDayName(){
        labelDayName = UILabel()
        labelDayName.textAlignment = .left
        labelDayName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDayName)
    }
    func setupLabelItenerary(){
        labelItenerary = UILabel()
        labelItenerary.textAlignment = .left
        labelItenerary.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelItenerary.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelItenerary)
    }
   
    func setuplabelPeople(){
        labelPeople = UILabel()
        labelPeople.textAlignment = .left
        labelPeople.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPeople)
    }
    func setuplabelIteneraryData(){
        labelIteneraryData = UILabel()
        labelIteneraryData.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelIteneraryData)
    }
    
    func setupDeletePlan(){
        deletePlan = UIButton(type: .system)
        deletePlan.setTitle("Delete Plan", for: .normal)
        deletePlan.setTitleColor(.white, for: .normal)
                
        deletePlan.backgroundColor = .red
        deletePlan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) // Adjust the font size as needed

        deletePlan.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deletePlan)
    }
    
    func setupShowPeople(){
        showPeople = UIButton(type: .system)
        showPeople.setTitle("See Who's on your Plan ?", for: .normal)
        showPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showPeople)
    }
    
    func setupImage(){
        imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    func setupTableViewExpense(){
        tableViewExpense = UITableView()
        tableViewExpense.separatorStyle = .singleLine
        tableViewExpense.layer.borderColor = UIColor.black.cgColor
        //tableViewExpense.layer.borderWidth = 1.0
        tableViewExpense.separatorColor = .blue
       // tableViewExpense.sepa
        //tableViewExpense.layer.borderColor = .none
        tableViewExpense.register(TableViewItineraryCell.self, forCellReuseIdentifier: "itinerary")
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
    
}

    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelDate.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelDate.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelDates.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 10),
            labelDates.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelDates.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelPeople.topAnchor.constraint(equalTo: labelDates.bottomAnchor, constant: 25),
            labelPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelPeople.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelTravelPeople.topAnchor.constraint(equalTo: labelPeople.bottomAnchor, constant: 10),
            labelTravelPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelTravelPeople.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            showPeople.topAnchor.constraint(equalTo: labelPeople.bottomAnchor, constant: 5),
            showPeople.leadingAnchor.constraint(equalTo: labelTravelPeople.leadingAnchor, constant: 20),
            
            labelItenerary.topAnchor.constraint(equalTo: showPeople.bottomAnchor, constant: 25),
            labelItenerary.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelItenerary.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tableViewExpense.topAnchor.constraint(equalTo: labelItenerary.topAnchor, constant: 20),
           
            tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewExpense.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableViewExpense.bottomAnchor.constraint(equalTo: deletePlan.topAnchor, constant: -3),
            
//            tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            tabBarView.heightAnchor.constraint(equalToConstant: 50),
            
           // deletePlan.topAnchor.constraint(equalTo: tableViewExpense.bottomAnchor),
            deletePlan.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            deletePlan.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            deletePlan.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: labelTravelPeople.bottomAnchor, constant: 32),
            imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
