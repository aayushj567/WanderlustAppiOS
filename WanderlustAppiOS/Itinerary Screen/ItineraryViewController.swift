import UIKit
import FirebaseAuth
import FirebaseFirestore

struct Day: Codable {
    @DocumentID var id: String?
    var name: String
    var destinationIds: [String]?
    var planId: String?
    var destinations: [Destination]? = []// Add planId to link back to the parent plan
    
    enum CodingKeys: String, CodingKey {
        case id, name, destinationIds, planId, destinations
    }
}


class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itineraryView: ItineraryView!
    var days: [Day] = []
    var onIconTapped: ((Int) -> Void)?
    var selectedDates: [Date] = []
    var selectedUserIds: [String] = []
    var destinationIds: [String] = []
    
    override func loadView() {
        itineraryView = ItineraryView(frame: UIScreen.main.bounds)
        view = itineraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itineraryView.tableView.delegate = self
        itineraryView.tableView.dataSource = self
        itineraryView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
        
        itineraryView.startDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        itineraryView.endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        itineraryView.saveButton.addTarget(self, action: #selector(saveItinerary), for: .touchUpInside)
        
        updateDaysFromDates()
        setupTabBarActions()
        print("Selected Users: \(selectedUserIds)")
    }
    
    func setupTabBarActions() {
        for subview in itineraryView.tabBarView.subviews {
            if let stackView = subview as? UIStackView {
                for iconView in stackView.arrangedSubviews {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
                    iconView.addGestureRecognizer(tapGesture)
                }
            }
        }
    }
    
    @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
        guard let iconView = sender.view else { return }
        let index = iconView.tag
        onIconTapped?(index)
    }
    
    @objc func saveItinerary() {
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("No user signed in")
        }
        
        let db = Firestore.firestore()
        let plansRef = db.collection("plans")
        let planDocument = plansRef.document()
        
        var newPlan = Plan(
            name: itineraryView.planNameLabel.text ?? "Untitled Plan",
            dateFrom: selectedDates.first ?? Date(),
            dateTo: selectedDates.last ?? Date(),
            dayIds: [],
            owner: currentUser.uid,
            guests: selectedUserIds
            
        )
        print(newPlan)
        do {
            try planDocument.setData(from: newPlan) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Plan successfully saved!")
                    self.saveDays(planId: planDocument.documentID, planDocument: planDocument)
                    let nextScreen = MyPlansViewController()
                    self.navigationController?.pushViewController(nextScreen, animated: true)
                }
            }
        } catch let error {
            print("Error serializing plan: \(error)")
        }
    }
    
    func saveDays(planId: String, planDocument: DocumentReference) {
        let db = Firestore.firestore()
        let daysRef = db.collection("days")
        
        var dayIds: [String] = []
        
        for day in days {
            let dayDocument = daysRef.document()
            var dayCopy = day
            dayCopy.planId = planId
            
            
            do {
                try dayDocument.setData(from: dayCopy) { error in
                    if let error = error {
                        print("Error saving day: \(error)")
                    } else {
                        print("Day \(day.name) successfully saved!")
                        dayIds.append(dayDocument.documentID)
                        self.saveDestinations(dayId: dayDocument.documentID, dayDocument: dayDocument, destinations: day.destinations ?? [])
                    }
                }
            } catch let error {
                print("Error serializing day: \(error)")
            }
        }
        print(days)
        
        planDocument.updateData(["dayIds": dayIds]) { error in
            if let error = error {
                print("Error updating plan with day IDs: \(error)")
            } else {
                print("Plan updated with day IDs")
            }
        }
    }
    
    func saveDestinations(dayId: String, dayDocument: DocumentReference, destinations: [Destination]) {
        let db = Firestore.firestore()
        let destinationsRef = db.collection("destinations")
        
        for destination in destinations {
            let destinationDocument = destinationsRef.document()
            var destinationCopy = destination
            destinationCopy.dayId = dayId
            
            do {
                try destinationDocument.setData(from: destinationCopy) { error in
                    if let error = error {
                        print("Error saving destination: \(error)")
                    } else {
                        print("Destination \(destination.name) successfully saved!")
                        self.destinationIds.append(destinationDocument.documentID)
                        print(destinationDocument.documentID)
                    }
                }
            } catch let error {
                print("Error serializing destination: \(error)")
            }
        }
        
        print(self.destinationIds)
        dayDocument.updateData(["destinationIds": self.destinationIds]) { error in
            if let error = error {
                print("Error updating day with destination IDs: \(error)")
            } else {
                print("Day updated with destination IDs")
            }
        }
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        updateDaysFromDates()
    }
    
    func updateDaysFromDates() {
        guard let startDate = selectedDates.first, let endDate = selectedDates.last else {
            days = []
            itineraryView.tableView.reloadData()
            return
        }
        
        let calendar = Calendar.current
        let dateRange = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        
        if dateRange >= 0 {
            days = (0...dateRange).map { Day(name: "Day \($0 + 1)", destinationIds: [], planId: nil, destinations: []) }
        } else {
            let swappedDateRange = calendar.dateComponents([.day], from: endDate, to: startDate).day ?? 0
            days = (0...swappedDateRange).map { Day(name: "Day \($0 + 1)", destinationIds: [], planId: nil, destinations: []) }
        }
        
        itineraryView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = days[indexPath.row]
        let destinationDetails = day.destinations?.map { "\($0.name) - Duration: \($0.duration ?? "")" }.joined(separator: "\n") ?? ""
        cell.textLabel?.text = "\(day.name):\n\(destinationDetails)"
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchVC = SearchDestinationController()
        searchVC.onDestinationsSelected = { [weak self] selectedDestinations in
            guard let self = self else { return }
            self.days[indexPath.row].destinations = selectedDestinations
            self.itineraryView.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
