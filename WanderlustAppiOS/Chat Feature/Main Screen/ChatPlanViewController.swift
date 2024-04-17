import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatPlanViewController: UIViewController {
    
//    private var tableView = UITableView()
    var chatPlanView = ChatPlanView()
    var plans = [Plan]()
    var userID: String?
    let db = Firestore.firestore()
    
    override func loadView() {
        view = chatPlanView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        // Fetch current user's UID
        userID = Auth.auth().currentUser?.uid
        chatPlanView.tableView.dataSource = self
        chatPlanView.tableView.delegate = self
        // Fetch plans where the current user is the owner or included in guests
        fetchPlans()
    }
    
//    private func setupTableView() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(ChatPlanTableViewCell.self, forCellReuseIdentifier: "PlanCell")
//        
//        // Set constraints
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
//        ])
//    }
    
    private func fetchPlans() {
        guard let userID = userID else {
            return
        }
        
        let queryForOwner = db.collection("plans").whereField("owner", isEqualTo: userID)
        
        queryForOwner.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else if querySnapshot!.isEmpty {
                print("No plans found for this user.")
                // Handle the absence of plans here, such as displaying a message to the user
            } else {
                for document in querySnapshot!.documents {
                    do {
                        if let planID = document.documentID as? String,
                           let planName = document.data()["name"] as? String{
                            var plan = Plan(id: planID, name: planName)
                            plan.id = document.documentID
                            self.plans.append(plan)
                        }
                    } catch {
                        print("Error decoding plan: \(error)")
                    }
                }
            }
            chatPlanView.tableView.reloadData()
            self.fetchPlansForGuests()
        }
    }

    private func fetchPlansForGuests() {
        guard let userID = userID else {
            return
        }
        
        let queryForGuests = db.collection("plans").whereField("guests", arrayContains: userID)
        
        queryForGuests.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else if querySnapshot!.isEmpty {
                print("No plans found for this user.")
                // Handle the absence of plans here, such as displaying a message to the user
            } else {
                for document in querySnapshot!.documents {
                    do {
                        if let planID = document.documentID as? String,
                           let planName = document.data()["name"] as? String{
                            var plan = Plan(id: planID, name: planName)
                            plan.id = document.documentID
                            self.plans.append(plan)
                        }
                    } catch {
                        print("Error decoding plan: \(error)")
                    }
                }
                
                chatPlanView.tableView.reloadData()
            }
        }
    }

    
}
// MARK: - UITableViewDataSource

extension ChatPlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfPlans = plans.count
        if numberOfPlans == 0 {
            print("hi \(numberOfPlans)")
            // Show placeholder message when plans array is empty
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            messageLabel.text = "No plans found"
            messageLabel.textColor = .gray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 20)
            messageLabel.sizeToFit()

            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
        }
        else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        return numberOfPlans
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatPlan, for: indexPath) as! ChatPlanTableViewCell
        
        // Configure the cell
        let plan = plans[indexPath.row]
        cell.planName.text = plan.name ?? "Unnamed Plan"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatPlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection if needed
        tableView.deselectRow(at: indexPath, animated: true)
//        let chatViewController = ChatViewController()
        let chatViewController = ChatViewController2()
       let plan = plans[indexPath.row]
//        print(plans)
        chatViewController.title = "messages"
        chatViewController.planId = plan.id
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

