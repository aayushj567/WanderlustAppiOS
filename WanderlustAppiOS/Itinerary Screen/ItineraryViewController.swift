//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
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
//
//class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var tableView: UITableView!
//    var startDatePicker: UIDatePicker!
//    var endDatePicker: UIDatePicker!
//    var days: [Day] = []
//    var saveButton : UIButton!
//    var tabBarView: UIView!
//    var onIconTapped: ((Int) -> Void)?
//    var planNameLabel:UILabel!
//    var selectedDates: [Date] = []
//    var selectedUsers: [User] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        updateDaysFromDates() // Initial setup for the days based on the date range
//        saveButton.addTarget(self, action: #selector(saveItinerary), for: .touchUpInside)
//    }
//
//    func setupUI() {
//        view.backgroundColor = .white
//        
//        planNameLabel = UILabel()
//        planNameLabel.text = "Your Plan Name"
//        planNameLabel.textAlignment = .center
//        planNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        planNameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Start Date Picker
//        
//        startDatePicker = UIDatePicker()
//        startDatePicker.datePickerMode = .date
//        startDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
//        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
//
//        // End Date Picker
//        endDatePicker = UIDatePicker()
//        endDatePicker.datePickerMode = .date
//        endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
//        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
//
//        // Setting up the tableView
//        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        
//        saveButton = UIButton()
//        saveButton.translatesAutoresizingMaskIntoConstraints = false
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.backgroundColor = .systemBlue // Example color
//        saveButton.layer.cornerRadius = 5
//        setupTabBarView()
//        view.addSubview(planNameLabel)
//        view.addSubview(saveButton)
//        // Add subviews
//        view.addSubview(tableView)
//        view.addSubview(startDatePicker)
//        view.addSubview(endDatePicker)
//        view.addSubview(saveButton)
//
//        // Apply Auto Layout
//        applyConstraints()
//    }
//    @objc func saveItinerary()
//    {
//        let db = Firestore.firestore()
//            guard let currentUser = Auth.auth().currentUser else {
//                fatalError("No user signed in")
//            }
//            
//            guard let startDate = selectedDates.first, let endDate = selectedDates.last else {
//                print("No selected dates")
//                return
//            }
//            
//            let newPlan = Plan(
//                name: planNameLabel.text ?? "Untitled Plan",
//                dateFrom: startDate,
//                dateTo: endDate,
//                days: days,
//                owner: currentUser.uid
//            )
//        
////        let db = Firestore.firestore()  // Get a reference to the Firestore service
////        guard let currentUser = Auth.auth().currentUser else {
////                   fatalError("No user signed in")
////               }
////            // Create an instance of the Plan
////            let newPlan = Plan(
////                name: planNameLabel.text ?? "Untitled Plan",
////                dateFrom: startDatePicker.date,
////                dateTo: endDatePicker.date,
////                days: days,
////                owner: currentUser.uid  // Use the appropriate user identifier
////            )
//
//            // Convert and set the plan data
//            do {
//                let planRef = db.collection("plans").document()  // Create a new document reference
//                try planRef.setData(from: newPlan) { error in
//                    if let error = error {
//                        print("Error writing document: \(error)")
//                    } else {
//                        print("Plan successfully saved!")
//                        // Here you can perform additional actions on successful save
//                        let nextScreen = MyPlansViewController()
//                        self.navigationController?.pushViewController(nextScreen, animated: true)
//                        
//                    }
//                }
//            } catch let error {
//                print("Error serializing plan: \(error)")
//            }
//    }
//    func setupTabBarView() {
//        tabBarView = UIView()
//        tabBarView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tabBarView)
//
//        // Create a stack view for the icons
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = .fillEqually // This will distribute the space equally among the icons
//        stackView.alignment = .center
//        stackView.axis = .horizontal
//        tabBarView.addSubview(stackView)
//        
//        // Add constraints to the stack view
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
//            stackView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor)
//        ])
//        
//        // Initialize icon views and add them to the stack view
//        let iconNames = ["house", "list.bullet", "message", "person.crop.circle"]
//        for (index, iconName) in iconNames.enumerated() {
//            let iconImageView = UIImageView(image: UIImage(systemName: iconName))
//            iconImageView.contentMode = .scaleAspectFit
//            iconImageView.isUserInteractionEnabled = true
//            iconImageView.tag = index  // Set the tag to the index of the iconName
//
//            // Add a gesture recognizer to each icon
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
//            iconImageView.addGestureRecognizer(tapGesture)
//            
//            stackView.addArrangedSubview(iconImageView)
//        }
//    }
//
//    @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
//            guard let iconView = sender.view else { return }
//            let index = iconView.tag
//            // Handle the icon tap based on the index
//            print("Icon at index \(index) was tapped.")
//                // Handle the icon tap, switch views accordingly
//                if(index == 0){
//                    let homeView = CalendarViewController()
//                    navigationController?.pushViewController(homeView, animated: true)
//                }
//                if(index == 1){
//                    let myplansVC = MyPlansViewController()
//                    navigationController?.pushViewController(myplansVC, animated: true)
//                }
//                if(index == 2)
//                {
//                    let chatView = ChatPlanViewController()
//                    navigationController?.pushViewController(chatView, animated: true)
//                }
//                print("Icon at index \(index) was tapped.")
//                if(index == 3)
//                {
//                    let profileView = ShowProfileViewController()
//                    navigationController?.pushViewController(profileView, animated: true)
//                }
//                guard let iconView = sender.view else { return }
//                //let index = iconView.tag
//                // The view controller that holds this view will set this closure to handle the icon tap.
//                onIconTapped?(index)
//            }
//    
//    func applyConstraints() {
//        NSLayoutConstraint.activate([
//            planNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
//            planNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            planNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            startDatePicker.topAnchor.constraint(equalTo: planNameLabel.bottomAnchor, constant: 20),
//            startDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
//            endDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tableView.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 20),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -8),
//            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tabBarView.heightAnchor.constraint(equalToConstant: 50),
//            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            saveButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
//            saveButton.heightAnchor.constraint(equalToConstant: 50)
//            
//        ])
//    }
//
//    @objc func dateChanged(_ sender: UIDatePicker) {
//        updateDaysFromDates()
//    }
//    
//    func updateDaysFromDates() {
//        guard let startDate = selectedDates.first, let endDate = selectedDates.last else {
//            days = []
//            tableView.reloadData()
//            return
//        }
//        
//        let calendar = Calendar.current
//        let dateRange = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
//        
//        if dateRange >= 0 {
//            days = (0...dateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
//        } else {
//            // If the date range is negative, swap the start and end dates
//            let swappedDateRange = calendar.dateComponents([.day], from: endDate, to: startDate).day ?? 0
//            days = (0...swappedDateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
//        }
//        
//        tableView.reloadData()
//    }
//
////    func updateDaysFromDates() {
////        let start = startDatePicker.date
////        let end = endDatePicker.date
////        
////        // Ensure the end date is not earlier than the start date
////        if end >= start {
////            let calendar = Calendar.current
////            let dateRange = calendar.dateComponents([.day], from: start, to: end).day ?? 0
////            days = (0...dateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
////        } else {
////            days = []  // Clear days if the end date is before the start date
////        }
////        tableView.reloadData()
////    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return days.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
//        let day = days[indexPath.row]
//        // Using newline to separate destination names instead of commas
//        let destinationDetails = day.destinations.map { "\($0.name) - Duration: \($0.duration)" }.joined(separator: "\n")
//            cell.textLabel?.text = "\(day.name):\n\(destinationDetails)"
//            cell.textLabel?.numberOfLines = 0// Allow unlimited lines for text label
//        cell.accessoryType = .detailDisclosureButton
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let searchVC = SearchDestinationController()
//        searchVC.onDestinationsSelected = { [weak self] selectedDestinations in
//            guard let self = self else { return }
//            self.days[indexPath.row].destinations = selectedDestinations
//            self.tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//        navigationController?.pushViewController(searchVC, animated: true)
//    }
//}


import UIKit
import FirebaseAuth
import FirebaseFirestore

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itineraryView: ItineraryView!
    var days: [Day] = []
    var onIconTapped: ((Int) -> Void)?

    var planNameLabel:UILabel!
    var destinationIds: [String] = []


    var selectedDates: [Date] = []
    var selectedUsers: [User] = []
    
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
        print("Selected Users: \(selectedUsers)")
    }

    @objc func saveItinerary() {
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("No user signed in")
        }

        let db = Firestore.firestore()
        let plansRef = db.collection("plans")
        let planDocument = plansRef.document()

        var newPlan = Plan(
            name: planNameLabel.text ?? "Untitled Plan",
            dateFrom: startDatePicker.date,
            dateTo: endDatePicker.date,
            dayIds: [],
            owner: currentUser.uid
            
        )

        do {
            try planDocument.setData(from: newPlan) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Plan successfully saved!")
                    // After saving the plan, proceed to save the days.
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
            dayCopy.planId = planId  // Assign planId to day

            do {
                try dayDocument.setData(from: dayCopy) { error in
                    if let error = error {
                        print("Error saving day: \(error)")
                    } else {
                        print("Day \(day.name) successfully saved!")
                        dayIds.append(dayDocument.documentID)
                        // Save destinations for this day and update day with destination IDs
                        self.saveDestinations(dayId: dayDocument.documentID, dayDocument: dayDocument, destinations: day.destinations!)
                    }
                }
            } catch let error {
                print("Error serializing day: \(error)")
            }
            
        }

        // Update the plan document with the day IDs after all days are saved
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
            destinationCopy.dayId = dayId  // Assign dayId to destination

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

        // Update the day document with the destination IDs after all destinations are saved
        print(self.destinationIds)
        dayDocument.updateData(["destinationIds": self.destinationIds]) { error in
            if let error = error {
                print("Error updating day with destination IDs: \(error)")
            } else {
                print("Day updated with destination IDs")
            }
        }
    }

    func setupTabBarView() {
        tabBarView = UIView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)

        // Create a stack view for the icons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually // This will distribute the space equally among the icons
        stackView.alignment = .center
        stackView.axis = .horizontal
        tabBarView.addSubview(stackView)
        
        // Add constraints to the stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor)
        ])
        
        // Initialize icon views and add them to the stack view
        let iconNames = ["house", "list.bullet", "message", "person.crop.circle"]
        for (index, iconName) in iconNames.enumerated() {
            let iconImageView = UIImageView(image: UIImage(systemName: iconName))
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.isUserInteractionEnabled = true
            iconImageView.tag = index  // Set the tag to the index of the iconName

            // Add a gesture recognizer to each icon
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
            iconImageView.addGestureRecognizer(tapGesture)
            
            stackView.addArrangedSubview(iconImageView)

    
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
        let db = Firestore.firestore()
        guard let currentUser = Auth.auth().currentUser else {
            fatalError("No user signed in")
        }
        
        guard let startDate = selectedDates.first, let endDate = selectedDates.last else {
            print("No selected dates")
            return
        }
        
        let newPlan = Plan(
            name: itineraryView.planNameLabel.text ?? "Untitled Plan",
            dateFrom: startDate,
            dateTo: endDate,
            days: days,
            owner: currentUser.uid
        )
        
        do {
            let planRef = db.collection("plans").document()
            try planRef.setData(from: newPlan) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Plan successfully saved!")
                    let nextScreen = MyPlansViewController()
                    self.navigationController?.pushViewController(nextScreen, animated: true)
                }
            }
        } catch let error {
            print("Error serializing plan: \(error)")
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
            days = (0...dateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
        } else {
            let swappedDateRange = calendar.dateComponents([.day], from: endDate, to: startDate).day ?? 0
            days = (0...swappedDateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
        }
        
        itineraryView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = days[indexPath.row]

        // Using newline to separate destination names instead of commas
        let destinationDetails = day.destinations?.map { "\($0.name) - Duration: \($0.duration)" }.joined(separator: "\n") ?? "No destinations available"

            cell.textLabel?.text = "\(day.name):\n\(destinationDetails)"
            cell.textLabel?.numberOfLines = 0  // Allow unlimited lines for text label
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
