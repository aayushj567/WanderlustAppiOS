//
//  TableViewContactsCell.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class TableViewItineraryCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelDayName: UILabel!
    var labelDestinationName: UILabel!
    var imageReceipt: UIImageView!
    var separatorView: UIView! // Separator view

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setuplabelDayName()
        setuplabelDestinationName()
        setupimageReceipt()
        setupSeparatorView() // Setup separator view

        initConstraints()
        
    }
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10.0
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setuplabelDayName(){
        labelDayName = UILabel()
        labelDayName.translatesAutoresizingMaskIntoConstraints = false
        labelDayName.font = UIFont.boldSystemFont(ofSize: 15.0)
        labelDayName.textColor = .systemBlue

        wrapperCellView.addSubview(labelDayName)
    }
    func setuplabelDestinationName(){
        labelDestinationName = UILabel()
        labelDestinationName.translatesAutoresizingMaskIntoConstraints = false
        labelDestinationName.font = UIFont.boldSystemFont(ofSize: 15.0)
        labelDestinationName.numberOfLines = 0 // Allow multiple lines
                labelDestinationName.lineBreakMode = .byTruncatingTail
        wrapperCellView.addSubview(labelDestinationName)
    }
//    func setuplabelBudget(){
//        labelPeople = UILabel()
//        labelPeople.translatesAutoresizingMaskIntoConstraints = false
//        labelPeople.font = UIFont.boldSystemFont(ofSize: 15.0)
//        wrapperCellView.addSubview(labelPeople)
//    }
//    func setuplabelPlace(){
//        labelOwner = UILabel()
//        labelOwner.translatesAutoresizingMaskIntoConstraints = false
//        labelOwner.textColor = .systemBlue
//        labelOwner.font = UIFont.boldSystemFont(ofSize: 15.0)
//        wrapperCellView.addSubview(labelOwner)
//    }
    func setupimageReceipt(){
        imageReceipt = UIImageView()
        imageReceipt.image = UIImage(systemName: "photo.fill")
        imageReceipt.tintColor = .black
        imageReceipt.contentMode = .scaleToFill
        imageReceipt.clipsToBounds = true
        imageReceipt.layer.cornerRadius = 10
        imageReceipt.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageReceipt)
    }
    
    func setupSeparatorView() {
               separatorView = UIView()
               separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5) // Adjust color and alpha as needed
               separatorView.translatesAutoresizingMaskIntoConstraints = false
               self.addSubview(separatorView)
           }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelDayName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 14),
            labelDayName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 110),
            labelDayName.heightAnchor.constraint(equalToConstant: 20),
            
            labelDestinationName.topAnchor.constraint(equalTo: labelDayName.bottomAnchor, constant: 4),
            labelDestinationName.leadingAnchor.constraint(equalTo: labelDayName.leadingAnchor),
            labelDestinationName.heightAnchor.constraint(lessThanOrEqualTo: wrapperCellView.heightAnchor),
            labelDestinationName.heightAnchor.constraint(equalToConstant: 20),
            
            imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                       separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                       separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                       separatorView.heightAnchor.constraint(equalToConstant: 1),
            
                   
            wrapperCellView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
