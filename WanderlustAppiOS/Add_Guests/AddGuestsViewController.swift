import UIKit

class AddGuestsViewController: UIViewController {
    
    let addGuestView = AddGuestsView()
    var guests: [String] = ["John Doe", "Jane Smith", "Michael Johnson"]
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
        return guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addGuestPeople", for: indexPath) as! AddPeopleTableViewCell
        cell.personIconImageView.image = UIImage(systemName: "person.circle")
        cell.personIconImageView.sizeToFit()
        cell.personIconImageView.contentMode = .scaleAspectFill
        cell.personIconImageView.clipsToBounds = true
        cell.personNameLabel.text = guests[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


