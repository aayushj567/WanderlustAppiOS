import UIKit
import FirebaseFirestore
import FirebaseAuth

class ChatPlanViewController: UIViewController {
    
    private var tableView = UITableView()
    
    var plans = [Plan]()
    var userID: String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "chat"
        view.backgroundColor = .white
        setupTableView()
        
        // Fetch current user's UID
        userID = Auth.auth().currentUser?.uid
        
        // Fetch plans where the current user is the owner or included in guests
        fetchPlans()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatPlanTableViewCell.self, forCellReuseIdentifier: "PlanCell")
        
        // Set constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func fetchPlans() {
        guard let userID = userID else {
            return
        }
        
        let queryForOwner = db.collection("plans").whereField("owner", isEqualTo: userID)
        
        queryForOwner.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        if let planData = document.data() as? [String: Any] {
                            var plan = try Firestore.Decoder().decode(Plan.self, from: planData)
                            print(plan.name)
                            plan.id = document.documentID
                            print(plan)
                            self.plans.append(plan)
                        }
                    } catch {
                        print("Error decoding plan: \(error)")
                    }
                }
                
                self.fetchPlansForGuests()
            }
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
            } else {
                for document in querySnapshot!.documents {
                    do {
                        if let planData = document.data() as? [String: Any] {
                            var plan = try Firestore.Decoder().decode(Plan.self, from: planData)
                            plan.id = document.documentID
                            self.plans.append(plan)
                        }
                    } catch {
                        print("Error decoding plan: \(error)")
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
}
// MARK: - UITableViewDataSource

extension ChatPlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! ChatPlanTableViewCell
        
        // Configure the cell
        let plan = plans[indexPath.row]
        print(plan.name!)
        cell.planNameLabel.text = plan.name ?? "Unnamed Plan"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatPlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection if needed
        let chatViewController = ChatViewController()
        let plan = plans[indexPath.row]
        chatViewController.planId = plan.id
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

