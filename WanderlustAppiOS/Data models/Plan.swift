//
//  Contact.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift


struct Plan{
    @DocumentID var id: String?
    var name: String?
    var dateFrom: String?
    var dateTo: String?
    var days: [Days]?
    var owner : User?
    var guests: [User]?
    
    init(name: String? = nil, dateFrom: String? = nil, dateTo: String? = nil, days: [Days]? = nil, owner: User? = nil, guests: [User]? = nil) {
        self.name = name
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.days = days
        self.owner = owner
        self.guests = guests
    }
}
