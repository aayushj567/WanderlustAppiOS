//
//  ShowContactView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ShowPlanDetailsView: UIView {

    var labelName: UILabel!
    var labelDateFrom: UILabel!
    var labelDateTo: UILabel!
    var labelPeople: UILabel!
    var labelTravelPeople: UILabel!
    var labelBudget: UILabel!
    var labelPlace: UILabel!
    var labelItenerary: UILabel!
    var labelIteneraryData: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelName()
        setuplabelDateTo()
        setuplabelTravelPeople()
        setuplabelBudget()
        setuplabelDateFrom()
        setuplabelPlace()
        setuplabelPeople()
        setupLabelItenerary()
        setuplabelIteneraryData()
        setupImage()
        initConstraints()
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.addSubview(labelName)
    }
    func setuplabelDateFrom(){
        labelDateFrom = UILabel()
        labelDateFrom.textAlignment = .center
        labelDateFrom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDateFrom)
    }
    func setuplabelDateTo(){
        labelDateTo = UILabel()
        labelDateTo.textAlignment = .center
        labelDateTo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDateTo)
    }
    func setuplabelTravelPeople(){
        labelTravelPeople = UILabel()
        labelTravelPeople.textAlignment = .center
        labelTravelPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTravelPeople)
    }
    func setuplabelBudget(){
        labelBudget = UILabel()
        labelBudget.textAlignment = .center
        labelBudget.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelBudget)
    }
    func setupLabelItenerary(){
        labelItenerary = UILabel()
        labelItenerary.textAlignment = .center
        labelItenerary.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelItenerary.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelItenerary)
    }
    func setuplabelPlace(){
        labelPlace = UILabel()
        labelPlace.textAlignment = .center
        labelPlace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPlace)
    }
    func setuplabelPeople(){
        labelPeople = UILabel()
        labelPeople.textAlignment = .center
        labelPeople.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelPeople.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPeople)
    }
    func setuplabelIteneraryData(){
        labelIteneraryData = UILabel()
        labelIteneraryData.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelIteneraryData)
    }
    
    func setupImage(){
        imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelPlace.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 32),
            labelPlace.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelPlace.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelDateFrom.topAnchor.constraint(equalTo: labelPlace.bottomAnchor, constant: 32),
            labelDateFrom.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            labelDateTo.topAnchor.constraint(equalTo: labelPlace.bottomAnchor, constant: 32),
            labelDateTo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 250),
            
            labelBudget.topAnchor.constraint(equalTo: labelDateTo.bottomAnchor, constant: 32),
            labelBudget.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelBudget.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelItenerary.topAnchor.constraint(equalTo: labelBudget.bottomAnchor, constant: 32),
            labelItenerary.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelItenerary.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelIteneraryData.topAnchor.constraint(equalTo: labelItenerary.bottomAnchor, constant: 32),
            labelIteneraryData.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelIteneraryData.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelPeople.topAnchor.constraint(equalTo: labelIteneraryData.bottomAnchor, constant: 32),
            labelPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelPeople.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelTravelPeople.topAnchor.constraint(equalTo: labelPeople.bottomAnchor, constant: 10),
            labelTravelPeople.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelTravelPeople.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
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
