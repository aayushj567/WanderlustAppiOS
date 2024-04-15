//
//  AddPeopleTableViewCell.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/5/24.
//

import UIKit

class AddPeopleTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var personIconImageView: UIImageView!
    var personNameLabel: UILabel!
    var addButton: UIButton!
    
    var addButtonTapHandler: (() -> Void)?
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
            addButtonTapHandler?()
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupPersonIconImage()
        setupPersonNameLabel()
        setupAddButton()
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.layer.borderColor = UIColor.green.cgColor
        self.addSubview(wrapperCellView)
    }
    
    func setupPersonIconImage(){
        personIconImageView = UIImageView()
//        personIconImageView.image = UIImage(named: "person.circle")
        personIconImageView.contentMode = .scaleAspectFill
        personIconImageView.clipsToBounds = true
        personIconImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(personIconImageView)
    }
    
    func setupPersonNameLabel(){
        personNameLabel = UILabel()
        personNameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(personNameLabel)
    }
    
    func setupAddButton(){
        addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .lightGray// Set background color to red
        addButton.setTitleColor(.green, for: .normal) // Set text color to green
        addButton.layer.cornerRadius = 8 // Set corner radius
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            personIconImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 2),
            personIconImageView.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            personIconImageView.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -10),
            personIconImageView.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -10),
            
            personNameLabel.leadingAnchor.constraint(equalTo: personIconImageView.trailingAnchor, constant: 8),
            personNameLabel.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            personNameLabel.heightAnchor.constraint(equalToConstant: 20),
            personNameLabel.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            
            addButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -25),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            addButton.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 88)
        ])
        
    }
    
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
