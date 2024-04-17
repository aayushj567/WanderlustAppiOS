//
//  contactsTableViewCell.swift
//  WA5_Jaiswal_6534
//
//  Created by Aayush Jaiswal on 2/17/24.
//

import UIKit

class PlansTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    
    //MARK: declaring the ImageView for receipt image...
    var contactPhoto: UIImageView!
    //var phoneTypeLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupContactPhoto()
        setupNameLabel()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.7
        
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    //Adding the ImageView for receipt...
    func setupContactPhoto(){
        contactPhoto = UIImageView()
        contactPhoto.image = UIImage(systemName: "person.fill")
        contactPhoto.contentMode = .scaleToFill
        contactPhoto.clipsToBounds = true
        contactPhoto.layer.cornerRadius = 10
        contactPhoto.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(contactPhoto)
    }
    
    func setupNameLabel(){
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(emailLabel)
    }
    
    func setupPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(phoneLabel)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            
            contactPhoto.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            contactPhoto.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            //MARK: it is better to set the height and width of an ImageView with constraints...
            contactPhoto.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            contactPhoto.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: contactPhoto.trailingAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 32),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 32),
            emailLabel.widthAnchor.constraint(lessThanOrEqualTo: nameLabel.widthAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.heightAnchor.constraint(equalToConstant: 32),
            phoneLabel.widthAnchor.constraint(lessThanOrEqualTo: nameLabel.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 104)
        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

