//
//  ShowContactView.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ShowContactView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var labelAddressHeading: UILabel!
    var labelAddress: UILabel!
    var labelCity: UILabel!
    //var labelZip: UILabel!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelPhone()
        setupLabelAddress()
        setupLabelCity()
        setupLabelEmail()
        //setupLabelZip()
        setupLabelAddressHeading()
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
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.textAlignment = .center
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    func setupLabelPhone(){
        labelPhone = UILabel()
        labelPhone.textAlignment = .center
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhone)
    }
    func setupLabelAddress(){
        labelAddress = UILabel()
        labelAddress.textAlignment = .center
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress)
    }
    func setupLabelCity(){
        labelCity = UILabel()
        labelCity.textAlignment = .center
        labelCity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCity)
    }
//    func setupLabelZip(){
//        labelZip = UILabel()
//        labelZip.textAlignment = .center
//        labelZip.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelZip)
//    }
    func setupLabelAddressHeading(){
        labelAddressHeading = UILabel()
        labelAddressHeading.textAlignment = .center
        labelAddressHeading.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelAddressHeading.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddressHeading)
    }
    
    func setupImage(){
        imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 40),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            labelPhone.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelPhone.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelCity.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 32),
            labelCity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelCity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelAddressHeading.topAnchor.constraint(equalTo: labelCity.bottomAnchor, constant: 32),
            labelAddressHeading.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelAddressHeading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelAddress.topAnchor.constraint(equalTo: labelAddressHeading.bottomAnchor, constant: 10),
            labelAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelAddress.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 32),
            imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
