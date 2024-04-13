//
//  TableViewContactsCell.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class TableViewContactsCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelDateFrom: UILabel!
    var labelDateTo: UILabel!
    var labelPeople: UILabel!
    var labelBudget: UILabel!
    var labelPlace: UILabel!
    var imageReceipt: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setuplabelName()
        //setuplabelDateFrom()
        setuplabelDateTo()
        setuplabelBudget()
        //setuplabelPeople()
        setupimageReceipt()
        setuplabelPlace()
        initConstraints()
        
    }
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setuplabelName(){
        labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelName)
    }
    func setuplabelDateTo(){
        labelDateTo = UILabel()
        labelDateTo.translatesAutoresizingMaskIntoConstraints = false
        labelDateTo.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelDateTo)
    }
    func setuplabelBudget(){
        labelPeople = UILabel()
        labelPeople.translatesAutoresizingMaskIntoConstraints = false
        labelPeople.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelPeople)
    }
    func setuplabelPlace(){
        labelPlace = UILabel()
        labelPlace.translatesAutoresizingMaskIntoConstraints = false
        labelPlace.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelPlace)
    }
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
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 14),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 100),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            
            labelDateTo.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelDateTo.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelDateTo.heightAnchor.constraint(equalToConstant: 20),
        
            
            labelPeople.topAnchor.constraint(equalTo: labelDateTo.bottomAnchor, constant: 4),
            labelPeople.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelPeople.heightAnchor.constraint(equalToConstant: 20),
            
            labelPlace.topAnchor.constraint(equalTo: labelPeople.bottomAnchor, constant: 4),
            labelPlace.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelPlace.heightAnchor.constraint(equalToConstant: 20),
            
            imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            
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
