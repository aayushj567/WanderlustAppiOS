import FirebaseFirestore
import FirebaseFirestoreSwift

struct Plan: Codable {
    @DocumentID var id: String?
    var name: String?
    var dateFrom: Date?
    var dateTo: Date?
    var dayIds: [String]?
    var owner: String?
    var guests: [String]?
    var days: [Day]? = []

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateFrom
        case dateTo
        case dayIds
        case owner
        case guests
        case days
    }
}


