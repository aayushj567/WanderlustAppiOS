import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddGuestsViewController: UIViewController {
    
    let addGuestView = AddGuestsView()
    var users: [User] = []
    var filteredUsers: [User] = []
    var selectedUserIds: [String] = []
    var selectedDates: [Date] = []
    var planName: String?
    let userId = Auth.auth().currentUser?.uid
    
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
        
        addGuestView.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
            if(index == 0){
                let homeView = FirstViewController()
                navigationController?.pushViewController(homeView, animated: true)
            }
            if(index == 1){
                let myplansVC = MyPlansViewController()
                navigationController?.pushViewController(myplansVC, animated: true)
            }
            if(index == 2)
            {
                let chatView = ChatPlanViewController()
                navigationController?.pushViewController(chatView, animated: true)
            }
            print("Icon at index \(index) was tapped.")
            if(index == 3)
            {
                let profileView = ShowProfileViewController()
                navigationController?.pushViewController(profileView, animated: true)
            }
        }
    }
    
    func fetchUsers() {
        let db = Firestore.firestore()
        db.collection("users").whereField("id", isNotEqualTo: userId).getDocuments { [weak self] (querySnapshot, error) in
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
        itineraryViewController.selectedUserIds = selectedUserIds
        itineraryViewController.planName = planName
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
        
        cell.checkboxButton.isSelected = selectedUserIds.contains(user.id ?? "")
        
        cell.userTapped = { [weak self] isSelected in
            guard let self = self else { return }
            if let userId = user.id {
                if isSelected {
                    self.selectedUserIds.append(userId)
                } else {
                    self.selectedUserIds.removeAll(where: { $0 == userId })
                }
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
