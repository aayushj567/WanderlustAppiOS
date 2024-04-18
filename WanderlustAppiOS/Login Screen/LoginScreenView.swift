//
//  LoginView.swift
//  WA7_Basu_7118
//
//  Created by Anwesa Basu on 11/03/24.
//

import UIKit

class LoginView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    var imageViewLogo: UIImageView!
    var labelTitle: UILabel!
    var backgroundImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupbuttonLogin()
        setupbuttonRegister()
        setupImageViewLogo()
        setupLabelTitle()
        setupBackgroundImage()
        initConstraints()
    }
    
    func setupLabelTitle() {
            labelTitle = UILabel()
            labelTitle.text = "WanderLust"
            labelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            labelTitle.textColor = .systemBlue
            labelTitle.textAlignment = .center
            labelTitle.font = UIFont.boldSystemFont(ofSize: 34)
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(labelTitle)
        }
    
    func setupImageViewLogo() {
        imageViewLogo = UIImageView()
        imageViewLogo.contentMode = .scaleAspectFit
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        imageViewLogo.image = UIImage(named: "logo") // Replace "logo" with the actual logo image name in your assets.
        self.addSubview(imageViewLogo)
    }
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.layer.borderWidth = 1
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupBackgroundImage(){
                backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "Image")
                backgroundImage.contentMode = .scaleAspectFill // Adjust content mode as needed
                backgroundImage.clipsToBounds = true // Clip to bounds to avoid image overflow
                backgroundImage.alpha = 0.7
                // Add the UIImageView as the background of the view
                self.addSubview(backgroundImage)
                self.sendSubviewToBack(backgroundImage)
    }
    
    
    func setupbuttonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .systemBlue
        
        buttonLogin.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitleColor(.white, for: .normal)  // Change .white to any UIColor you need
         
         // Set the background color of the button
        //buttonLogin.backgroundColor = .black
        self.addSubview(buttonLogin)
        
        let sidePadding: CGFloat = 20 // Adjust padding to your preference
            NSLayoutConstraint.activate([
                buttonLogin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sidePadding),
                buttonLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sidePadding),
                // Add any other necessary constraints (e.g., topAnchor, heightAnchor)
            ])
    }
    
    
        func setupbuttonRegister(){
            buttonRegister = UIButton(type: .system)
            buttonRegister.setTitle("Register", for: .normal)
            buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
            buttonRegister.translatesAutoresizingMaskIntoConstraints = false
            buttonRegister.backgroundColor = .systemGreen
            buttonRegister.setTitleColor(.white, for: .normal)  // Change .white to any UIColor you need
             
             // Set the background color of the button
            //buttonRegister.backgroundColor = .black
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
                // Logo constraints
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageViewLogo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
                imageViewLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageViewLogo.widthAnchor.constraint(equalToConstant: 150), // Set to your desired width
                imageViewLogo.heightAnchor.constraint(equalToConstant: 150), // Set to your desired height

                // Email field constraints
                textFieldEmail.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 32),
                textFieldEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                textFieldEmail.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                
                // Password field constraints
                textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
                textFieldPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                textFieldPassword.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                
                // Login button constraints
                buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
                buttonLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                buttonLogin.widthAnchor.constraint(equalTo: textFieldPassword.widthAnchor),
                buttonLogin.heightAnchor.constraint(equalToConstant: 50), // Set to your desired height
                
                // Register button constraints
                buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
                buttonRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                buttonRegister.widthAnchor.constraint(equalTo: textFieldPassword.widthAnchor),
                buttonRegister.heightAnchor.constraint(equalToConstant: 50), // Set to your desired height
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


