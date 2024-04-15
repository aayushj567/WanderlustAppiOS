import UIKit
import FirebaseAuth
import FirebaseFirestore

struct Day: Codable {
    var name: String
    var destinations: [Destination]
}

class ItineraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var startDatePicker: UIDatePicker!
    var endDatePicker: UIDatePicker!
    var days: [Day] = []
    var saveButton : UIButton!
    var tabBarView: UIView!
    var onIconTapped: ((Int) -> Void)?
    var planNameLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateDaysFromDates() // Initial setup for the days based on the date range
        saveButton.addTarget(self, action: #selector(saveItinerary), for: .touchUpInside)
    }

    func setupUI() {
        view.backgroundColor = .white
        
        planNameLabel = UILabel()
        planNameLabel.text = "Your Plan Name"
        planNameLabel.textAlignment = .center
        planNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        planNameLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start Date Picker
        
        startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false

        // End Date Picker
        endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false

        // Setting up the tableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue // Example color
        saveButton.layer.cornerRadius = 5
        setupTabBarView()
        view.addSubview(planNameLabel)
        view.addSubview(saveButton)
        // Add subviews
        view.addSubview(tableView)
        view.addSubview(startDatePicker)
        view.addSubview(endDatePicker)
        view.addSubview(saveButton)

        // Apply Auto Layout
        applyConstraints()
    }
    @objc func saveItinerary()
    {
        let db = Firestore.firestore()  // Get a reference to the Firestore service
        guard let currentUser = Auth.auth().currentUser else {
                   fatalError("No user signed in")
               }
            // Create an instance of the Plan
            let newPlan = Plan(
                name: planNameLabel.text ?? "Untitled Plan",
                dateFrom: startDatePicker.date,
                dateTo: endDatePicker.date,
                days: days,
                owner: currentUser.uid  // Use the appropriate user identifier
            )

            // Convert and set the plan data
            do {
                let planRef = db.collection("plans").document()  // Create a new document reference
                try planRef.setData(from: newPlan) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Plan successfully saved!")
                        // Here you can perform additional actions on successful save
                        let nextScreen = MyPlansViewController()
                        self.navigationController?.pushViewController(nextScreen, animated: true)
                        
                    }
                }
            } catch let error {
                print("Error serializing plan: \(error)")
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
        }
    }

    @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
            guard let iconView = sender.view else { return }
            let index = iconView.tag
            // Handle the icon tap based on the index
            print("Icon at index \(index) was tapped.")
                // Handle the icon tap, switch views accordingly
                if(index == 0){
                    let homeView = CalendarViewController()
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
                guard let iconView = sender.view else { return }
                //let index = iconView.tag
                // The view controller that holds this view will set this closure to handle the icon tap.
                onIconTapped?(index)
            }

    func applyConstraints() {
        NSLayoutConstraint.activate([
            planNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            planNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startDatePicker.topAnchor.constraint(equalTo: planNameLabel.bottomAnchor, constant: 20),
            startDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
            endDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -8),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: tabBarView.topAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

    @objc func dateChanged(_ sender: UIDatePicker) {
        updateDaysFromDates()
    }

    func updateDaysFromDates() {
        let start = startDatePicker.date
        let end = endDatePicker.date
        
        // Ensure the end date is not earlier than the start date
        if end >= start {
            let calendar = Calendar.current
            let dateRange = calendar.dateComponents([.day], from: start, to: end).day ?? 0
            days = (0...dateRange).map { Day(name: "Day \($0 + 1)", destinations: []) }
        } else {
            days = []  // Clear days if the end date is before the start date
        }
        tableView.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = days[indexPath.row]
        // Using newline to separate destination names instead of commas
        let destinationDetails = day.destinations.map { "\($0.name) - Duration: \($0.duration)" }.joined(separator: "\n")
            cell.textLabel?.text = "\(day.name):\n\(destinationDetails)"
            cell.textLabel?.numberOfLines = 0// Allow unlimited lines for text label
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchVC = SearchDestinationController()
        searchVC.onDestinationsSelected = { [weak self] selectedDestinations in
            guard let self = self else { return }
            self.days[indexPath.row].destinations = selectedDestinations
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
