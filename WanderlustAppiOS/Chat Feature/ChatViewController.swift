import UIKit
 
class ChatViewController: UIViewController {
 
    var chatView: ChatView!
 
    override func loadView() {
        chatView = ChatView()
        //view.backgroundColor = .white
        view = chatView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        chatView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
 
    @objc func sendMessage() {
        guard let messageText = chatView.messageTextField.text, !messageText.isEmpty else {
            print("No message to send.")
            return
        }
        // Here, you'd typically integrate with your chat backend to send the message
        print("Message sent: \(messageText)")
        // Optionally clear the message text field after sending
        chatView.messageTextField.text = ""
    }
}


