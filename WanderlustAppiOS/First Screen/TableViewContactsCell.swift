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
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var labelAddress: UILabel!
    var labelCity: UILabel!
    var labelZip: UILabel!
    var imageReceipt: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setuplabelName()
        //setuplabelEmail()
        setuplabelPhone()
        setuplabelCity()
        //setuplabelAddress()
        setupimageReceipt()
        setupLabelZip()
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
    func setuplabelPhone(){
        labelPhone = UILabel()
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelPhone)
    }
//    func setuplabelAddress(){
//        labelCity = UILabel()
//        labelCity.translatesAutoresizingMaskIntoConstraints = false
//        labelCity.font = UIFont.boldSystemFont(ofSize: 15.0)
//        wrapperCellView.addSubview(labelCity)
//    }
    func setuplabelCity(){
        labelAddress = UILabel()
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        labelAddress.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelAddress)
    }
    func setupLabelZip(){
        labelZip = UILabel()
        labelZip.translatesAutoresizingMaskIntoConstraints = false
        labelZip.font = UIFont.boldSystemFont(ofSize: 15.0)
        wrapperCellView.addSubview(labelZip)
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
            
            labelPhone.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelPhone.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelPhone.heightAnchor.constraint(equalToConstant: 20),
        
            
            labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 4),
            labelAddress.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelAddress.heightAnchor.constraint(equalToConstant: 20),
            
            labelZip.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 4),
            labelZip.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelZip.heightAnchor.constraint(equalToConstant: 20),
            
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
