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
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupnewPlanButton()
        setupallPlansButton()
        setupBackgroundImage()
        setupWelcomeLabel()
        setupTextLabel()
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
        
        let sidePadding: CGFloat = 20
            NSLayoutConstraint.activate([
                newPlanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                newPlanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
            ])
    }
    
    
        func setupallPlansButton(){
            allPlansButton = UIButton(type: .system)
            allPlansButton.setTitle("Show Plans", for: .normal)
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
                backgroundImage.image = UIImage(named: "your_image_name_here")
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
        labelWelcomeLabel.font = UIFont.boldSystemFont(ofSize: 36.0)
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
            
            labelWelcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            labelWelcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelWelcomeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            labelTextLabel.topAnchor.constraint(equalTo: labelWelcomeLabel.bottomAnchor, constant: 60),
            labelTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //labelDestinationName.heightAnchor.constraint(equalToConstant: 20),
            // Login button constraints
            //newPlanButton.topAnchor.constraint(equalTo: .bottomAnchor, constant: 32),
            newPlanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newPlanButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        //newPlanButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            newPlanButton.heightAnchor.constraint(equalToConstant: 50), // Set to your desired height
            
            // Register button constraints
            allPlansButton.topAnchor.constraint(equalTo: newPlanButton.bottomAnchor, constant: 16),
            allPlansButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //newPlanButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            // allPlansButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            allPlansButton.heightAnchor.constraint(equalToConstant: 50), // Set t
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
