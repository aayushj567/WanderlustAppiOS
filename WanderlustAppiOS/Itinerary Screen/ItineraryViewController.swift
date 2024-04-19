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
    var planName: String?
    var planToEdit: Plan?
    override func loadView() {
        itineraryView = ItineraryView(frame: UIScreen.main.bounds)
        if let planName = planName{
            itineraryView.planNameLabel.text = planName
        }
        else{
            itineraryView.planNameLabel.text = "Your Plan"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let dateString = dateFormatter.string(from: selectedDates.first!)
        let dateString2 = dateFormatter.string(from: selectedDates.last!)
        
        //itineraryView.startDateInfoLabel.text = selectedDates.first?.description
        itineraryView.endDateInfoLabel.text = "\(dateString) - \(dateString2)"
        view = itineraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Itinerary"
        itineraryView.tableView.delegate = self
        itineraryView.tableView.dataSource = self
        itineraryView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
        
        itineraryView.saveButton.addTarget(self, action: #selector(saveItinerary), for: .touchUpInside)
        itineraryView.estimateBudgetButton.addTarget(self, action: #selector(calculateAndDisplayEstimate), for: .touchUpInside)
        if let plan = planToEdit {
              configureViewForEditing(plan)
          } else {
              updateDaysFromDates() // Setup the view for creating a new plan
          }
        //setupTabBarActions()
        print("Selected Users: \(selectedUserIds)")
        itineraryView.onIconTapped = { [unowned self] index in
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
            if(index == 3)
            {
                let profileView = ShowProfileViewController()
                navigationController?.pushViewController(profileView, animated: true)
            }
        }
    }
    func configureViewForEditing(_ plan: Plan) {
        // Set the plan name label
        itineraryView.planNameLabel.text = plan.name

        // Load days and destinations from the plan
        if let days = plan.days {
                self.days = days.sorted { day1, day2 in
                    guard let dayNumber1 = Int(day1.name.replacingOccurrences(of: "Day ", with: "")),
                          let dayNumber2 = Int(day2.name.replacingOccurrences(of: "Day ", with: "")) else {
                        return false
                    }
                    return dayNumber1 < dayNumber2
                }
                updateDaysFromDates()
                itineraryView.tableView.reloadData()
            }
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
    @objc func calculateAndDisplayEstimate() {
        let basePricePerDestination = 15.0  // Base price per destination
        let multiplierRange = (15...30)     // Price range multiplier
        
        let totalDestinations = days.flatMap { $0.destinations }.count
        let randomMultiplier = Double(multiplierRange.randomElement() ?? 15)  // Random multiplier within range
        let estimatedBudget = Double(totalDestinations) * randomMultiplier
        
        // Assuming there's a method or a label to display this estimated budget
        let formattedBudget = String(format: "%.2f", estimatedBudget)
        showAlert(title: "Estimated Budget", message: "The estimated budget for your trip is $\(formattedBudget).")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func saveItinerary() {
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("No user signed in")
        }
        let emptyDays = days.filter { $0.destinations?.isEmpty ?? true }
            if !emptyDays.isEmpty {
                let alert = UIAlertController(title: "Incomplete Itinerary", message: "Please add destinations for all days before saving.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        
        let db = Firestore.firestore()
        let plansRef = db.collection("plans")
        var planDocument = plansRef.document()
        
        if let plan = planToEdit {
            var showPlan = ShowPlanDetailsViewController()
            showPlan.receivedPlan = plan
            showPlan.onDeletePlan()
            planDocument = plansRef.document(plan.id!)
        }
        
       
        
        var newPlan = Plan(
            name: itineraryView.planNameLabel.text ?? "Untitled Plan",
            dateFrom: selectedDates.first ?? Date(),
            dateTo: selectedDates.last ?? Date(),
            dayIds: [],
            owner: currentUser.uid,
            guests: selectedUserIds
            
        )
        if var plan = planToEdit {
            plan.days = days
//            print("Edited Plan\(plan)")
//            print(plan.id!)
//            print(plan.days!.count)
            newPlan.id = plan.id
            
            
            
        }
        
        //print(newPlan)
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

    
//    @objc func saveItinerary() {
//        guard let currentUser = Auth.auth().currentUser else {
//            fatalError("No user signed in")
//        }
//        let emptyDays = days.filter { $0.destinations?.isEmpty ?? true }
//            if !emptyDays.isEmpty {
//                let alert = UIAlertController(title: "Incomplete Itinerary", message: "Please add destinations for all days before saving.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                return
//            }
//        if let plan = planToEdit {
//            var showPlan = ShowPlanDetailsViewController()
//            showPlan.receivedPlan = plan
//            showPlan.onDeletePlan()
//        }
//        
//        let db = Firestore.firestore()
//        let plansRef = db.collection("plans")
//        let planDocument = plansRef.document()
//        
//        var newPlan = Plan(
//            name: itineraryView.planNameLabel.text ?? "Untitled Plan",
//            dateFrom: selectedDates.first ?? Date(),
//            dateTo: selectedDates.last ?? Date(),
//            dayIds: [],
//            owner: currentUser.uid,
//            guests: selectedUserIds
//            
//        )
//        if var plan = planToEdit {
//            plan.days = days
//            print("Edited Plan\(plan)")
//            print(plan.id!)
//            print(plan.days!.count)
//            
//            
//        }
//        
//        //print(newPlan)
//        do {
//            try planDocument.setData(from: newPlan) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                } else {
//                    print("Plan successfully saved!")
//                    self.saveDays(planId: planDocument.documentID, planDocument: planDocument)
//                    let nextScreen = MyPlansViewController()
//                    self.navigationController?.pushViewController(nextScreen, animated: true)
//                }
//            }
//        } catch let error {
//            print("Error serializing plan: \(error)")
//        }
//    }
    
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
                days = (0...dateRange).map { index in
                    let dayName = "Day \(index + 1)"
                    if let existingDay = days.first(where: { $0.name == dayName }) {
                        return existingDay // Use existing day to preserve any added destinations
                    } else {
                        return Day(name: dayName, destinationIds: [], planId: nil, destinations: []) // Create new day
                    }
                }
            }
            
        
        itineraryView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = days[indexPath.row]
        if let destinations = day.destinations, !destinations.isEmpty {
               // Join all destination names into a single string
               let destinationDetails = destinations.map { "\($0.name)" }.joined(separator: "\n")
               cell.textLabel?.text = "\(day.name):\n\(destinationDetails)"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
           } else {
               // Placeholder text that prompts user to add destinations
               cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
               cell.textLabel?.text = "\(day.name):\nClick to select destinations"
           }
                cell.textLabel?.numberOfLines = 0
                 cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
              cell.backgroundColor = UIColor.systemGray6 // Set a background color
              cell.layer.borderColor = UIColor.darkGray.cgColor
              cell.layer.borderWidth = 2
                  cell.layer.cornerRadius = 8
                  cell.clipsToBounds = true
           cell.textLabel?.numberOfLines = 0
            //cell.accessoryType = .detailDisclosureButton
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
