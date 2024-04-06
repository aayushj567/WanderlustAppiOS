//
//  Contact.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import Foundation
import UIKit


struct Plan{
    var name: String?
    var datefrom: String?
    var dateto: String?
    var budget: String?
    var people: String?
    var place: String?
    var type: String?
    var image: UIImage?
    var id: Int?
    
    init(id:Int? = nil, name: String? = nil, datefrom: String? = nil, dateto:String? = nil, people:String? = nil, budget:String? = nil, place:String? = nil, type: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.datefrom = datefrom
        self.dateto = dateto
        self.budget = budget
        self.place = place
        self.type = type
        self.people = people
        self.image = image
        self.id = id
    }
}
