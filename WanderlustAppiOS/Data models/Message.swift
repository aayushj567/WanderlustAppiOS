import Foundation
import FirebaseFirestoreSwift

struct Message: Codable {
    @DocumentID var id: String?
    var sender: String
    var planId: String
    var messageText: String
    var date: Date

    init(sender: String, planId: String, messageText: String, date: Date) {
        self.sender = sender
        self.planId = planId
        self.messageText = messageText
        self.date = date
    }
}

