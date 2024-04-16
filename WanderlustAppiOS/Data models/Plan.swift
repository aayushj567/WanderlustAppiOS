import FirebaseFirestore
import FirebaseFirestoreSwift

struct Plan: Codable {
    var id: String?
    var name: String?
    var dateFrom: Date?
    var dateTo: Date?
    var days: [Day]?
    var owner: String?
    var guests: [String]?
    
//    init(){
//        
//    }
//    init(id: String, name: String) {
//        self.id = id
//        self.name = name
//    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateFrom
        case dateTo
        case days
        case owner
        case guests
    }
}


