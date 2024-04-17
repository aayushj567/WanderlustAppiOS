//
//  RegistrationView.swift
//  WA7_Basu_7118
//
//  Created by Anwesa Basu on 11/03/24.
//
 
import UIKit
 
class FirstView: UIView {
 
    // text fields to fill out
    var newPlanButton: UIButton!
    var allPlansButton: UIButton!
    var backgroundImage: UIImageView!
    var labelWelcomeLabel:UILabel!
    var labelTextLabel: UILabel!
    var logoutButton: UIButton!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupnewPlanButton()
        setupallPlansButton()
        setupBackgroundImage()
        setupWelcomeLabel()
        setupTextLabel()
        setupLogoutButton()
        initConstraints()
    }
    
    func setupnewPlanButton(){
        newPlanButton = UIButton(type: .system)
        newPlanButton.setTitle("Create Plan", for: .normal)
        newPlanButton.backgroundColor = .systemBlue
        
        newPlanButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        newPlanButton.translatesAutoresizingMaskIntoConstraints = false
        newPlanButton.setTitleColor(.white, for: .normal)  // Change .white to any UIColor you need
         
 
        self.addSubview(newPlanButton)
        
        let sidePadding: CGFloat = 20 // Adjust padding to your preference
            NSLayoutConstraint.activate([
                newPlanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                newPlanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
            ])
    }
    
    func setupLogoutButton(){
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        //logoutButton.backgroundColor = .systemBlue
        
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitleColor(.systemRed, for: .normal)
         
 
        self.addSubview(logoutButton)
        
        
    }
    
    
        func setupallPlansButton(){
            allPlansButton = UIButton(type: .system)
            allPlansButton.setTitle("My Plans", for: .normal)
            allPlansButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
            allPlansButton.translatesAutoresizingMaskIntoConstraints = false
            allPlansButton.backgroundColor = .systemGreen
            allPlansButton.setTitleColor(.white, for: .normal)  // Change .white to any UIColor you need
             
             // Set the background color of the button
            //allPlansButton.backgroundColor = .black
            self.addSubview(allPlansButton)
            
            let sidePadding: CGFloat = 20 // Adjust padding to your preference
                NSLayoutConstraint.activate([
                    allPlansButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                    allPlansButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
                    // Add any other necessary constraints (e.g., topAnchor, heightAnchor)
                ])
        }
    
    func setupBackgroundImage(){
                backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "Image")
                backgroundImage.contentMode = .scaleAspectFill // Adjust content mode as needed
                backgroundImage.clipsToBounds = true // Clip to bounds to avoid image overflow
                
                // Add the UIImageView as the background of the view
                self.addSubview(backgroundImage)
                self.sendSubviewToBack(backgroundImage)
    }
    
    
    func setupWelcomeLabel(){
        labelWelcomeLabel = UILabel()
        labelWelcomeLabel.textAlignment = .center
        labelWelcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        labelWelcomeLabel.font = UIFont.boldSystemFont(ofSize: 34.0)
        self.addSubview(labelWelcomeLabel)
    }
    
    func setupTextLabel(){
        labelTextLabel = UILabel()
        labelTextLabel.textAlignment = .center
        labelTextLabel.translatesAutoresizingMaskIntoConstraints = false
        labelTextLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        self.addSubview(labelTextLabel)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            labelWelcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            labelWelcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelWelcomeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            labelTextLabel.topAnchor.constraint(equalTo: labelWelcomeLabel.bottomAnchor, constant: 80),
            labelTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            newPlanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newPlanButton.topAnchor.constraint(equalTo: labelTextLabel.bottomAnchor, constant: 250),
            newPlanButton.heightAnchor.constraint(equalToConstant: 50),
            
            allPlansButton.topAnchor.constraint(equalTo: newPlanButton.bottomAnchor, constant: 16),
            allPlansButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            allPlansButton.heightAnchor.constraint(equalToConstant: 50),
            
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: allPlansButton.bottomAnchor, constant: 16),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
