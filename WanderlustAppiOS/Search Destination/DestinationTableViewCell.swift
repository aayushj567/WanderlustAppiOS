//
//  DestinationTableViewCell.swift
//  WanderlustAppiOS
//
//  Created by Anwesa Basu on 02/04/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



struct Destination: Codable {
    @DocumentID var id: String?
    var name: String
    var rating: String
    var admissionPrice: String?
    var isAddedToPlan: Bool
    var placeId: String?
    var photoReference: String?
    var imageBase64: String?   // Use a String to store the image data in Base64
    var duration: String?
    var dayId: String?

    // UIImage is not included here because it's not Codable
    var image: UIImage? {
        // UIImage does not get encoded/decoded, so it's computed from/to imageBase64
        get {
            guard let base64 = imageBase64, let imageData = Data(base64Encoded: base64) else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageBase64 = newValue?.jpegData(compressionQuality: 0.5)?.base64EncodedString()
        }
    }

    enum CodingKeys: String, CodingKey {
        case id,name, rating, admissionPrice, isAddedToPlan, placeId, photoReference, imageBase64, duration,dayId
    }
}



class DestinationTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
        var labelName: UILabel!
    var destinationImageView: UIImageView!
    var destinationNameLabel: UILabel!
    var  destinationRatingLabel: UILabel!
    var destinationPriceLabel: UILabel!
    var addToPlanCheckbox: UIButton!
    var addToPlanTapped: ((_ isSelected: Bool) -> Void)?

    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.isUserInteractionEnabled = false
            
            
            setupWrapperCellView()
            setupLabelName()
            setupDestinationLabelName()
            setupDestinationRatingLabel()
            setupDestinationPriceLabel()
            setupAddToPlanCheckbox()
            setupDestinationImageView()
            initConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func setupWrapperCellView(){
            wrapperCellView = UITableViewCell()
            
            //working with the shadows and colors...
            wrapperCellView.backgroundColor = .white
            wrapperCellView.layer.cornerRadius = 4.0
            wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
            wrapperCellView.layer.shadowOffset = .zero
            wrapperCellView.layer.shadowRadius = 2.0
            wrapperCellView.layer.shadowOpacity = 0.7
            wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.isUserInteractionEnabled = true
            self.addSubview(wrapperCellView)
        }
        
        func setupLabelName(){
            labelName = UILabel()
            labelName.font = UIFont.boldSystemFont(ofSize: 16)
            labelName.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.addSubview(labelName)
        }
        
        func initConstraints(){
            NSLayoutConstraint.activate([
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
                destinationImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
                                destinationImageView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
                                destinationImageView.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),
                               destinationImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
                               destinationImageView.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
                                destinationImageView.widthAnchor.constraint(equalToConstant: 150),
                destinationImageView.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, multiplier: 0.8),
                                
                labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
                        labelName.topAnchor.constraint(equalTo: destinationImageView.bottomAnchor, constant: 10),

                        // Rating label constraints
                        destinationRatingLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
                        destinationRatingLabel.topAnchor.constraint(equalTo: destinationImageView.bottomAnchor, constant: 10),
                        
                        // Price label constraints
                        destinationPriceLabel.trailingAnchor.constraint(equalTo: destinationRatingLabel.leadingAnchor, constant: -10),
                        destinationPriceLabel.topAnchor.constraint(equalTo: destinationImageView.bottomAnchor, constant: 10),
                addToPlanCheckbox.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 6),
                        addToPlanCheckbox.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
                        addToPlanCheckbox.widthAnchor.constraint(equalToConstant: 30),
                        addToPlanCheckbox.heightAnchor.constraint(equalToConstant: 30),
                        
                
                wrapperCellView.heightAnchor.constraint(equalToConstant: 250)
                
            ])
            let labelNameTrailingConstraint = labelName.trailingAnchor.constraint(lessThanOrEqualTo: destinationRatingLabel.leadingAnchor, constant: -8)
                labelNameTrailingConstraint.priority = UILayoutPriority(999)
                labelNameTrailingConstraint.isActive = true
            
        }
    func setupDestinationImageView() {
        destinationImageView = UIImageView()
        destinationImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(destinationImageView)
        
    }
    func setupDestinationLabelName() {
        destinationNameLabel = UILabel()
        destinationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        destinationNameLabel.textColor = .black
        wrapperCellView.addSubview(destinationNameLabel)
    }
    
    func setupDestinationRatingLabel() {
        destinationRatingLabel = UILabel()
        destinationRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationRatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        destinationRatingLabel.textColor = .gray
        wrapperCellView.addSubview(destinationRatingLabel)
    }
    
    func setupDestinationPriceLabel() {
        destinationPriceLabel = UILabel()
        destinationPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        destinationPriceLabel.textColor = .gray
        wrapperCellView.addSubview(destinationPriceLabel)
    }
    
    func setupAddToPlanCheckbox() {
        addToPlanCheckbox = UIButton()
        addToPlanCheckbox.translatesAutoresizingMaskIntoConstraints = false
        // Here you might want to set up different images for selected and normal states
        // For example:
        addToPlanCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        addToPlanCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        addToPlanCheckbox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        addToPlanCheckbox.isUserInteractionEnabled = true;
        
        self.addSubview(addToPlanCheckbox)

    }

    @objc func checkBoxTapped(_ sender: UIButton) {
        print("Clicked")
        sender.isSelected = !sender.isSelected
        addToPlanTapped?(sender.isSelected)
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
