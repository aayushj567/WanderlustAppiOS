import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddGuestsViewController: UIViewController {
    
    let addGuestView = AddGuestsView()
    var guests: [String] = ["John Doe", "Jane Smith", "Michael Johnson"]
    var users: [User] = []
    var selectedUsers: [User] = []
    var selectedDates: [Date] = []
    override func loadView() {
        view = addGuestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Guests"
        addGuestView.tableViewPeople.separatorStyle = .none
        addGuestView.tableViewPeople.separatorColor = .clear
        addGuestView.tableViewPeople.allowsSelection = false
        addGuestView.tableViewPeople.dataSource = self
        addGuestView.tableViewPeople.delegate = self
        addGuestView.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
        fetchUsers()
    }
    
    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting users: \(error)")
            } else {
                self.users = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: User.self)
                } ?? []
                self.addGuestView.tableViewPeople.reloadData()
            }
        }
    }
    
    @objc func onNextButtonTapped(){
//        let addItenaryController = ItineraryViewController()
//        navigationController?.pushViewController(addItenaryController, animated: true)
        
        let itineraryViewController = ItineraryViewController()
            itineraryViewController.selectedDates = selectedDates
            itineraryViewController.selectedUsers = selectedUsers
            navigationController?.pushViewController(itineraryViewController, animated: true)
    }
}



extension AddGuestsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
        // ...
        let user = users[indexPath.row]
        cell.addButtonTapHandler = { [weak self] in
                guard let self = self else { return }
                if !self.selectedUsers.contains(where: { $0.id == user.id }) {
                    self.selectedUsers.append(user)
                }
            }
        cell.personNameLabel.text = user.name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return guests.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
//        cell.personIconImageView.image = UIImage(systemName: "person.circle")
//        cell.personIconImageView.sizeToFit()
//        cell.personIconImageView.contentMode = .scaleAspectFill
//        cell.personIconImageView.clipsToBounds = true
//        cell.personNameLabel.text = guests[indexPath.row]
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


