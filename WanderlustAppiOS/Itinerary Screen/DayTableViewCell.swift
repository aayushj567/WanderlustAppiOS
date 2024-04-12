//
//  DayTableViewCell.swift
//  WanderlustAppiOS
//
//  Created by Anwesa Basu on 12/04/24.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let image = UIImageView()
    let ratingLabel = UILabel()
    let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with destination: Destination) {
        nameLabel.text = destination.name
        imageView?.image = destination.image ?? UIImage(systemName: "photo") // Use default image if none
        ratingLabel.text = "Rating: \(destination.rating)"
        priceLabel.text = "Price: \(destination.admissionPrice ?? "N/A")"
    }
}
