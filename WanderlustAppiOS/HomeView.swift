//
//  HomeView.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/3/24.
//

import UIKit

class HomeView: UIView {
    var welcomeLabel: UILabel!
//    var textFieldEmail: UITextField!
//    var textFieldPassword: UITextField!
//    var buttonRegister: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupWelcomeLabel()
//        setuptextFieldEmail()
//        setuptextFieldPassword()
//        setupbuttonRegister()
        
        initConstraints()
    }
    
    func setupWelcomeLabel(){
        welcomeLabel = UILabel()
        welcomeLabel.font = .boldSystemFont(ofSize: 14)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(welcomeLabel)
    }
    
//    func setuptextFieldEmail(){
//        textFieldEmail = UITextField()
//        textFieldEmail.placeholder = "Email"
//        textFieldEmail.keyboardType = .emailAddress
//        textFieldEmail.borderStyle = .roundedRect
//        textFieldEmail.autocorrectionType = .no
//        textFieldEmail.autocapitalizationType = .none
//        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textFieldEmail)
//    }
//    
//    func setuptextFieldPassword(){
//        textFieldPassword = UITextField()
//        textFieldPassword.placeholder = "Password"
//        textFieldPassword.textContentType = .password
//        textFieldPassword.isSecureTextEntry = true
//        textFieldPassword.borderStyle = .roundedRect
//        textFieldPassword.autocorrectionType = .no
//        textFieldPassword.autocapitalizationType = .none
//        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textFieldPassword)
//    }
//    
//    func setupbuttonRegister(){
//        buttonRegister = UIButton(type: .system)
//        buttonRegister.setTitle("Register", for: .normal)
//        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(buttonRegister)
//    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
//            textFieldEmail.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
//            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textFieldEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
//            
//            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
//            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
//            
//            buttonRegister.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
//            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
