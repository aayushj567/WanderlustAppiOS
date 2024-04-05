//
//  AddContactView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class AddContactView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPhone: UITextField!
    var textFieldAddress: UITextField!
    var textFieldCity: UITextField!
    var textFieldZip: UITextField!
    var labelPhoto: UILabel!
    var buttonSelectType: UIButton!
    var buttonTakePhoto: UIButton!
    var saveButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPhone()
        setupTextFieldAddress()
        setupTextFieldCity()
        setupTextFieldZip()
        setupbuttonSelectType()
        setupbuttonTakePhoto()
        setupLabelPhoto()
        setupSaveButton()
        initConstraints()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    func setupbuttonSelectType(){
        buttonSelectType = UIButton(type: .system)
        buttonSelectType.setTitle("Home", for: .normal)
        buttonSelectType.showsMenuAsPrimaryAction = true
        buttonSelectType.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonSelectType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectType)
    }
    func setupTextFieldPhone(){
        textFieldPhone = UITextField()
        textFieldPhone.placeholder = "Phone number"
        textFieldPhone.borderStyle = .roundedRect
        textFieldPhone.keyboardType = .phonePad
        textFieldPhone.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPhone)
    }
    func setupTextFieldAddress(){
        textFieldAddress = UITextField()
        textFieldAddress.placeholder = "Address"
        textFieldAddress.borderStyle = .roundedRect
        textFieldAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldAddress)
    }
    func setupTextFieldCity(){
        textFieldCity = UITextField()
        textFieldCity.placeholder = "City, State"
        textFieldCity.borderStyle = .roundedRect
        textFieldCity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldCity)
    }
    func setupTextFieldZip(){
        textFieldZip = UITextField()
        textFieldZip.placeholder = "ZIP"
        textFieldZip.borderStyle = .roundedRect
        textFieldZip.keyboardType = .numberPad
        textFieldZip.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldZip)
    }
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.tintColor = .black
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    func setupLabelPhoto(){
        labelPhoto = UILabel()
        labelPhoto.text = "Photo"
        labelPhoto.textColor = .gray
        labelPhoto.translatesAutoresizingMaskIntoConstraints = false
        labelPhoto.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.addSubview(labelPhoto)
    }
    
    func setupSaveButton(){
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(saveButton)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            textFieldName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 70),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelPhoto.bottomAnchor, constant: 15),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            labelPhoto.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: -5),
            labelPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldPhone.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 15),
            textFieldPhone.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldPhone.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:30),
            textFieldPhone.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -100),
            
            buttonSelectType.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 15),
            buttonSelectType.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            textFieldAddress.topAnchor.constraint(equalTo: textFieldPhone.bottomAnchor, constant: 15),
            textFieldAddress.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldAddress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            textFieldCity.topAnchor.constraint(equalTo: textFieldAddress.bottomAnchor, constant: 15),
            textFieldCity.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldCity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldCity.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            textFieldZip.topAnchor.constraint(equalTo: textFieldCity.bottomAnchor, constant: 15),
            textFieldZip.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldZip.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textFieldZip.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            saveButton.topAnchor.constraint(equalTo: textFieldZip.bottomAnchor, constant: 70),
            saveButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
}
