//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//class AddGuestsViewController: UIViewController {
//    
//    let addGuestView = AddGuestsView()
//    var guests: [String] = ["John Doe", "Jane Smith", "Michael Johnson"]
//    var users: [User] = []
//    var selectedUsers: [User] = []
//    var selectedDates: [Date] = []
//    override func loadView() {
//        view = addGuestView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Add Guests"
//        addGuestView.tableViewPeople.separatorStyle = .none
//        addGuestView.tableViewPeople.separatorColor = .clear
//        //addGuestView.tableViewPeople.allowsSelection = false
//        addGuestView.tableViewPeople.dataSource = self
//        addGuestView.tableViewPeople.delegate = self
//        addGuestView.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
//        fetchUsers()
//    }
//    
//    func fetchUsers() {
//        let db = Firestore.firestore()
//        db.collection("users").getDocuments { [weak self] (querySnapshot, error) in
//            guard let self = self else { return }
//            if let error = error {
//                print("Error getting users: \(error)")
//            } else {
//                self.users = querySnapshot?.documents.compactMap { document in
//                    try? document.data(as: User.self)
//                } ?? []
//                self.addGuestView.tableViewPeople.reloadData()
//            }
//        }
//    }
//    
//    @objc func onNextButtonTapped(){
////        let addItenaryController = ItineraryViewController()
////        navigationController?.pushViewController(addItenaryController, animated: true)
//        
//        let itineraryViewController = ItineraryViewController()
//            itineraryViewController.selectedDates = selectedDates
//            itineraryViewController.selectedUsers = selectedUsers
//            navigationController?.pushViewController(itineraryViewController, animated: true)
//    }
//}
//
//
//
//extension AddGuestsViewController: UITableViewDelegate, UITableViewDataSource{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return users.count
//        }
//        
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
//        let user = users[indexPath.row]
//        cell.checkBoxTapped = { [weak self] isSelected in
//            guard let self = self else { return }
//            if isSelected {
//                self.selectedUsers.append(user)
//            } else {
//                self.selectedUsers.removeAll(where: { $0.id == user.id })
//            }
//        }
//        cell.personNameLabel.text = user.name
//        return cell
//    }
//
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//

//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//class AddGuestsViewController: UIViewController {
//    
//    let addGuestView = AddGuestsView()
//    var users: [User] = []
//    var selectedUsers: [User] = []
//    var selectedDates: [Date] = []
//    
//    override func loadView() {
//        view = addGuestView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Add Guests"
//        addGuestView.tableViewPeople.separatorStyle = .none
//        addGuestView.tableViewPeople.separatorColor = .clear
//        addGuestView.tableViewPeople.dataSource = self
//        addGuestView.tableViewPeople.delegate = self
//        addGuestView.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
//        fetchUsers()
//    }
//    
//    func fetchUsers() {
//        let db = Firestore.firestore()
//        db.collection("users").getDocuments { [weak self] (querySnapshot, error) in
//            guard let self = self else { return }
//            if let error = error {
//                print("Error getting users: \(error)")
//            } else {
//                self.users = querySnapshot?.documents.compactMap { document in
//                    try? document.data(as: User.self)
//                } ?? []
//                self.addGuestView.tableViewPeople.reloadData()
//            }
//        }
//    }
//    
//    @objc func onNextButtonTapped() {
//        let itineraryViewController = ItineraryViewController()
//        itineraryViewController.selectedDates = selectedDates
//        itineraryViewController.selectedUsers = selectedUsers
//        navigationController?.pushViewController(itineraryViewController, animated: true)
//    }
//}
//
//extension AddGuestsViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
//        let user = users[indexPath.row]
//        cell.personNameLabel.text = user.name
//        
//        // Set the initial state of the checkbox based on whether the user is selected or not
//        cell.checkboxButton.isSelected = selectedUsers.contains(where: { $0.id == user.id })
//        
//        // Pass the user tapped closure to handle checkbox state changes
//        cell.userTapped = { [weak self] isSelected in
//            guard let self = self else { return }
//            if isSelected {
//                self.selectedUsers.append(user)
//            } else {
//                self.selectedUsers.removeAll(where: { $0.id == user.id })
//            }
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}


import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddGuestsViewController: UIViewController {
    
    let addGuestView = AddGuestsView()
    var users: [User] = []
    var filteredUsers: [User] = []
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
        addGuestView.tableViewPeople.dataSource = self
        addGuestView.tableViewPeople.delegate = self
        addGuestView.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
        addGuestView.searchBar.delegate = self
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
                self.filteredUsers = self.users
                self.addGuestView.tableViewPeople.reloadData()
            }
        }
    }
    
    @objc func onNextButtonTapped() {
        let itineraryViewController = ItineraryViewController()
        itineraryViewController.selectedDates = selectedDates
        itineraryViewController.selectedUsers = selectedUsers
        navigationController?.pushViewController(itineraryViewController, animated: true)
    }
}

extension AddGuestsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
        let user = filteredUsers[indexPath.row]
        cell.personNameLabel.text = user.name
        
        cell.checkboxButton.isSelected = selectedUsers.contains(where: { $0.id == user.id })
        
        cell.userTapped = { [weak self] isSelected in
            guard let self = self else { return }
            if isSelected {
                self.selectedUsers.append(user)
            } else {
                self.selectedUsers.removeAll(where: { $0.id == user.id })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddGuestsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = searchText.isEmpty ? users : users.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        addGuestView.tableViewPeople.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

