//
//  ChatViewController2.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/15/24.
//

import UIKit
import MessageKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import InputBarAccessoryView

struct Sender: SenderType{
    var senderId: String
    var displayName: String
}


struct CustomMessage: MessageType{
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

class ChatViewController2: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
    let database = Firestore.firestore()
    var messagesList = [MessageType]()
    var currentUserID: String = ""
    var currentUserName: String = ""
    var user: Sender?
    var planId: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            
            if user == nil {
                self.messagesList.removeAll()
                //self.chatScreen.tableViewMessages.reloadData()
            } else {
                self.currentUser = user
                self.currentUserID = currentUser?.uid as? String ?? ""
                self.currentUserName = currentUser?.displayName as? String ?? ""
                self.user = Sender(senderId: currentUserID, displayName: currentUserName)
                self.fetchMessagesForPlan()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
//    func avatar(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Avatar {
//            let initials = message.sender.displayName.prefix(1).uppercased()
//        print(initials)
//        print(Avatar(initials: String(initials)))
//            return Avatar(initials: String(initials))
////        return Avatar()
//    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        let sigil = Sigil(ship: Sigil.Ship(rawValue: message.sender.senderId)!, color: .black).image(with: CGSize(width: 24.0, height: 24.0))
        let initials = message.sender.displayName.prefix(1).uppercased()
        print(initials)
        let avatar = Avatar(initials: initials)
            avatarView.set(avatar: avatar)
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        // Create a new message object
//        let newMessage = CustomMessage(sender: user!, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text))
        //let newMessage = Cus(text: text, sender: currentSender(), messageId: UUID().uuidString, date: Date())
        let message = Message(sender: currentUserName, senderID: currentUserID, planId: planId!, messageText: text.trimmingCharacters(in: .whitespacesAndNewlines), date: Date())
        saveMessageToFireStore(message: message, planId: planId!)
        // Append the new message to your data source
//        messagesList.append(newMessage)
//        messagesCollectionView.reloadData()
        // Optionally, you can also insert the new message into your MessageKit data source and update the UI
        //messagesCollectionView.insertSections([messages.count - 1])

        // Clear the input field
        inputBar.inputTextView.text = ""
    }
    
    func formattedDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm" // Customize date format as needed
            return dateFormatter.string(from: date)
        }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
           // Return the desired height for the cellTopLabel
           return 20 // Adjust as needed
       }
    
    func saveMessageToFireStore(message: Message, planId: String) {
        do {
            var messageToSend = message
            messageToSend.id = nil // Make sure to clear the id before saving a new message
            //messageToSend.receiver = "" // Receiver is not needed
            
            let documentRef = try database.collection("messages").addDocument(from: messageToSend) { error in
                if let error = error {
                    print("Error adding message to Firestore: \(error)")
                } else {
                    print("Message added successfully")
                    
                }
            }
            let cm = CustomMessage(sender: self.user!, messageId: documentRef.documentID, sentDate: message.date, kind: .text(message.messageText))
            self.messagesList.append(cm)
            self.messagesCollectionView.reloadData()
        } catch {
            print("Error encoding message: \(error)")
        }
    }
    
    func currentSender() -> any MessageKit.SenderType {
        return user!
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> any MessageKit.MessageType {
        return messagesList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messagesList.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        let date = formattedDate(date: message.sentDate)
        return NSAttributedString(
            string: name + " " + date,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }

    
    func fetchMessagesForPlan() {
        guard let userID = currentUser?.email, let planId = planId else { return }
        
        database.collection("messages")
            .whereField("planId", isEqualTo: planId)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.messagesList.removeAll()
                for document in documents {
                    do {
                        let firebaseMessage = try document.data(as: Message.self)
                        
                        if firebaseMessage.senderID == currentUserID{
                            let message = CustomMessage(sender: user!, messageId: firebaseMessage.id!, sentDate: firebaseMessage.date, kind: .text(firebaseMessage.messageText))
                            self.messagesList.append(message)
                            self.messagesList.sort { $0.sentDate < $1.sentDate }
                            self.messagesCollectionView.reloadData()
                        }
                        else{
                            let otherUser = Sender(senderId: firebaseMessage.senderID, displayName: firebaseMessage.sender)
                            let message = CustomMessage(sender: otherUser, messageId: firebaseMessage.id!, sentDate: firebaseMessage.date, kind: .text(firebaseMessage.messageText))
                            self.messagesList.append(message)
                            self.messagesList.sort { $0.sentDate < $1.sentDate }
                            self.messagesCollectionView.reloadData()
                        }
                        
                        
                    } catch {
                        print("Error decoding message: \(error)")
                    }
                }
                
//                DispatchQueue.main.async {
//                    self.chatScreen.tableViewMessages.reloadData()
//                    self.scrollToBottom()
//                }
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension ChatViewController2 {
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//        // Return the default message style
//        return .bubble
//    }
//    
//    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        // Configure avatar view if needed
//    }
//
//    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        // Configure accessory view if needed
//    }
//
//    func messageHeaderView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView {
//        // Retrieve the message
//        let message = messagesList[indexPath.section]
//            
//            // Create a header view
//        let headerView = messagesCollectionView.dequeueReusableHeaderView(MessageReusableView.self, for: indexPath)
//        
//        // Apply sender's name and date to the labels directly
//        headerView = message.sender.displayName
//        headerView.timestampLabel.text = MessageKitDateFormatter.shared.string(from: message.sentDate)
//        
//        return headerView
//    }
//}
