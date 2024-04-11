//
//  Days.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/11/24.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift


struct User: Codable{
    @DocumentID var id: String?
    var name: String?
    var phone: String?
    var image: String?
    var email: String?
    
    init(name: String? = nil, phone: String? = nil, image: String? = nil, email: String? = nil) {
        self.name = name
        self.phone = phone
        self.image = image
        self.email = email
    }
    
}
