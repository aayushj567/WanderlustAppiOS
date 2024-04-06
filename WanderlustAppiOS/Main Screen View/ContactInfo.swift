//
//  Contact.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import Foundation
import UIKit

struct ContactInfo{
    var name:String?
    var email:String?
    var phone:String?
    var phoneType:String?
    var street:String?
    var city:String?
    var zip:String?
    
    var image:UIImage?
    
    init(_ name: String? = nil,
         _ email: String? = nil,
         _ phone: String? = nil,
         _ phoneType: String? = nil,
         _ street: String? = nil,
         _ city: String? = nil,
         _ zip: String? = nil,
         _ image: UIImage? = nil)
    {
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneType = phoneType
        self.street = street
        self.city = city
        self.zip = zip
        self.image = image
    }
}
