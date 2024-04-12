//
//  Days.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/11/24.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct Days: Codable{
    @DocumentID var id: String?
    var date: String?
    var name: String?
    var destinations: [String]?
    
    init(date: String? = nil, name: String? = nil, destinations: [String]? = nil) {
        self.date = date
        self.name = name
        self.destinations = destinations
    }
    
}
