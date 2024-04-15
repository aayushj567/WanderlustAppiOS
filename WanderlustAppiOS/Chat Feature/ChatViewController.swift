import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewController: UIViewController {
    
    let chatScreen = ChatScreenView()
    var currentUser: FirebaseAuth.User?
    var handleAuth: AuthStateDidChangeListenerHandle?
    let database = Firestore.firestore()
    var messagesList = [Message]()
    var planId: String? // Add a property to hold the plan ID
    
    override func loadView() {
        view = chatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollToBottom()
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            
            if user == nil {
                self.messagesList.removeAll()
                self.chatScreen.tableViewMessages.reloadData()
            } else {
                self.currentUser = user
                self.fetchMessagesForPlan()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatScreen.tableViewMessages.delegate = self
        chatScreen.tableViewMessages.dataSource = self
        chatScreen.tableViewMessages.separatorStyle = .none
        self.scrollToBottom()
        chatScreen.buttonSend.addTarget(self, action: #selector(onButtonSendTapped), for: .touchUpInside)
    }
    
    @objc func onButtonSendTapped() {
        guard let sender = currentUser?.email, let planId = planId else { return }
        
        let messageText = chatScreen.textFieldMessage.text ?? ""
        let date = Date()
        
        let message = Message(sender: sender, planId: planId, messageText: messageText, date: date) // Receiver is not needed
        saveMessageToFireStore(message: message, planId: planId)
        chatScreen.textFieldMessage.text = ""
        self.chatScreen.tableViewMessages.reloadData()
        self.scrollToBottom()
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
                        let message = try document.data(as: Message.self)
                        self.messagesList.append(message)
                    } catch {
                        print("Error decoding message: \(error)")
                    }
                }
                
                DispatchQueue.main.async {
                    self.chatScreen.tableViewMessages.reloadData()
                    self.scrollToBottom()
                }
            }
    }
    
    func saveMessageToFireStore(message: Message, planId: String) {
        do {
            var messageToSend = message
            messageToSend.id = nil // Make sure to clear the id before saving a new message
            //messageToSend.receiver = "" // Receiver is not needed
            
            _ = try database.collection("messages").addDocument(from: messageToSend) { error in
                if let error = error {
                    print("Error adding message to Firestore: \(error)")
                } else {
                    print("Message added successfully")
                }
            }
        } catch {
            print("Error encoding message: \(error)")
        }
    }
    
    func scrollToBottom() {
        let numberOfSections = self.chatScreen.tableViewMessages.numberOfSections
        let numberOfRows = self.chatScreen.tableViewMessages.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            self.chatScreen.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewMessagesID, for: indexPath) as! MessagesTableViewCell
        
        let message = messagesList[indexPath.row]
        print(message)
        cell.labelSender.text = message.sender
        cell.labelMessageText.text = message.messageText
        cell.labelDate.text = DateFormatter.localizedString(from: message.date, dateStyle: .medium, timeStyle: .short)
        
        if message.sender == currentUser?.email {
            cell.labelMessageText.textAlignment = .right
            cell.backgroundColor = .blue
        } else {
            cell.labelMessageText.textAlignment = .left
            cell.backgroundColor = .gray
        }
        
        return cell
    }
}
