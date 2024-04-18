//
//  RegistrationView.swift
//  WA7_Basu_7118
//
//  Created by Anwesa Basu on 11/03/24.
//

import UIKit

class RegistrationView: UIView {

    // text fields to fill out
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    // adding photos
    var labelPhoto:UILabel!
    var buttonTakePhoto: UIButton!
    // register button
    var buttonRegister: UIButton!
    var labelTitle: UILabel!
    var backgroundImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setuplabelPhoto()
        setupbuttonTakePhoto()
        setupbuttonRegister()
        setupLabelTitle()
        setupBackgroundImage()
        initConstraints()
    }
    
    func setupLabelTitle() {
            labelTitle = UILabel()
            labelTitle.text = "Please enter details"
            labelTitle.textAlignment = .center
            labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium) // Consider a system font that looks great on all devices.
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(labelTitle)
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.autocorrectionType = .no
        textFieldName.autocapitalizationType = .none
        textFieldName.layer.borderWidth = 1
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.autocorrectionType = .no
        textFieldEmail.layer.borderWidth = 1
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.keyboardType = .default
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.autocorrectionType = .no
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.enablePasswordToggle()
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setuplabelPhoto(){
        labelPhoto = UILabel()
        labelPhoto.text = "Add Profile Photo"
        labelPhoto.font = UIFont.boldSystemFont(ofSize: 14)
        labelPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoto)
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    func setupbuttonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = #colorLiteral(red: 0.1844881177, green: 0.4828699231, blue: 1, alpha: 1)
        //buttonRegister.layer.cornerRadius = 5.0
        buttonRegister.setTitleColor(UIColor.white, for: .normal)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
        
        let sidePadding: CGFloat = 20 // Adjust padding to your preference
            NSLayoutConstraint.activate([
                buttonRegister.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                buttonRegister.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
            ])
    }
    
    func setupBackgroundImage(){
                backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "Image")
                backgroundImage.contentMode = .scaleAspectFill // Adjust content mode as needed
                // Adjust the alpha value to make the background image more transparent
                backgroundImage.alpha = 0.9 // Adjust the alpha value as needed
                backgroundImage.clipsToBounds = true // Clip to bounds to avoid image overflow
                
                // Add the UIImageView as the background of the view
                self.addSubview(backgroundImage)
                self.sendSubviewToBack(backgroundImage)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Name field constraints
            textFieldName.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 48),
            // Increased the space from title to first text field
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
                
            // take photo button constraints
            buttonTakePhoto.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
                      
            // label constraints
            labelPhoto.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor),
            labelPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                      
            // Register button constraints
            buttonRegister.topAnchor.constraint(equalTo: labelPhoto.bottomAnchor, constant: 30),
            buttonRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

