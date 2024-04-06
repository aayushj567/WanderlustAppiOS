//
//  RegistrationView.swift
//  WA7_Basu_7118
//
//  Created by Anwesa Basu on 11/03/24.
//

import UIKit

class RegistrationView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonRegister: UIButton!
    var labelTitle: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupbuttonRegister()
        setupLabelTitle()
        initConstraints()
    }
    
    func setupLabelTitle() {
            labelTitle = UILabel()
            labelTitle.text = "Register"
            labelTitle.textAlignment = .center
            labelTitle.font = UIFont.systemFont(ofSize: 28, weight: .medium) // Consider a system font that looks great on all devices.
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(labelTitle)
        }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.keyboardType = .default
        //textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupbuttonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        buttonRegister.setTitleColor(.white, for: .normal)  // Change .white to any UIColor you need
         
         // Set the background color of the button
        buttonRegister.backgroundColor = .systemBlue
        self.addSubview(buttonRegister)
        
        let sidePadding: CGFloat = 20 // Adjust padding to your preference
            NSLayoutConstraint.activate([
                buttonRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                buttonRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
                // Add any other necessary constraints (e.g., topAnchor, heightAnchor)
            ])
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
                      labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      
                      // Name field constraints
                      textFieldName.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 48), // Increased the space from title to first text field
                      textFieldName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      textFieldName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                      
                      // Email field constraints
                      textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
                      textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      textFieldEmail.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                      
                      // Password field constraints
                      textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
                      textFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      textFieldPassword.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                      
                      // Register button constraints
                      buttonRegister.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
                      buttonRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                      buttonRegister.widthAnchor.constraint(equalTo: textFieldPassword.widthAnchor),
                      buttonRegister.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
