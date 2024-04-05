//
//  Contact.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import Foundation
import UIKit


struct Contact{
    var name: String?
    var email: String?
    var phone: String?
    var address: String?
    var city: String?
    var zip: String?
    var type: String?
    var image: UIImage?
    var id: Int?
    
    init(id:Int? = nil, name: String? = nil, email: String? = nil, phone:String? = nil, address:String? = nil, city:String? = nil, zip:String? = nil, type: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.phone = phone
        self.email = email
        self.city = city
        self.zip = zip
        self.type = type
        self.address = address
        self.image = image
        self.id = id
    }
}
