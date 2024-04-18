//
//  ViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class MyPlansViewController: UIViewController {
    let plansScreen = PlanScreenView()
    
    var plans = [Plan]()
    
    var currentplan = Plan()
    let db = Firestore.firestore()
    
    let userId = Auth.auth().currentUser?.uid
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // super.viewDidLoad()
        title = "My Plans"
        
        plansScreen.tableViewExpense.delegate = self
        plansScreen.tableViewExpense.dataSource = self
        plansScreen.tableViewExpense.separatorColor = .clear
        plansScreen.tableViewExpense.separatorStyle = .none
        
        fetchPlansForUser()
        fetchPlansForGuests()
        displayPlans()
//        NotificationCenter.default.addObserver(self, selector: #selector(dataDeleted), name: NSNotification.Name("DataDeleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeletePlan(_:)), name: NSNotification.Name("DeletePlan"), object: nil)
        plansScreen.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
            if(index == 0){
                let homeView = FirstViewController()
                navigationController?.pushViewController(homeView, animated: true)
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
    
    override func loadView() {
        view = plansScreen
        //getPlans()
       
    }
    
    func delegateOnAddContact(contact: Plan){
        plans.append(contact)
        plansScreen.tableViewExpense.reloadData()
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType: String, newImage: UIImage) {
        
        plans[idVal].name = newName
        
        plansScreen.tableViewExpense.reloadData()
    }
}


extension MyPlansViewController {
    func fetchPlansForUser() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }
        db.collection("plans").whereField("owner", isEqualTo: userId).getDocuments { [weak self] (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching plans: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                let group = DispatchGroup()
                
                
                documents.forEach { document in
                    let dateFromTimestamp = (document.data()["dateFrom"] as? Timestamp)?.dateValue() ?? Date()
                    let dateToTimestamp = (document.data()["dateTo"] as? Timestamp)?.dateValue() ?? Date()
                    
                    var plan = Plan(id: document.documentID, name: document.data()["name"] as? String ?? "No Name",dateFrom: dateFromTimestamp, dateTo: dateToTimestamp, owner: document.data()["owner"] as? String ?? "", guests:document.data()["guests"] as? [String] ?? [])
                    group.enter()
                    self?.fetchDaysForPlan(planId: plan.id!, completion: { days in
                        plan.days = days
                        self?.plans.append(plan)
                        group.leave()
                    })
                }
                self?.plansScreen.tableViewExpense.reloadData()
                group.notify(queue: .main) {
                    print("All plans have been fetched and structured.")
                    self?.displayPlans()
                    self?.plansScreen.tableViewExpense.reloadData()
                }
            }
        }

    func fetchPlansForGuests() {
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }
        db.collection("plans").whereField("guests", arrayContains: userId).getDocuments { [weak self] (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching plans: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                let group = DispatchGroup()
                
                documents.forEach { document in
                    let dateFromTimestamp = (document.data()["dateFrom"] as? Timestamp)?.dateValue() ?? Date()
                    let dateToTimestamp = (document.data()["dateTo"] as? Timestamp)?.dateValue() ?? Date()
                    
                    var plan = Plan(id: document.documentID, name: document.data()["name"] as? String ?? "No Name",dateFrom: dateFromTimestamp, dateTo: dateToTimestamp, owner: document.data()["owner"] as? String ?? "", guests:document.data()["guests"] as? [String] ?? [])
                    group.enter()
                    self?.fetchDaysForPlan(planId: plan.id!, completion: { days in
                        plan.days = days
                        self?.plans.append(plan)
                        group.leave()
                        
                    })
                }
                self?.plansScreen.tableViewExpense.reloadData()
                group.notify(queue: .main) {
                    print("All plans have been fetched and structured.")
                   // print(guests)
                    self?.displayPlans()
                    self?.plansScreen.tableViewExpense.reloadData()
                }
            }
        }
        func fetchDaysForPlan(planId: String, completion: @escaping ([Day]) -> Void) {
            db.collection("days").whereField("planId", isEqualTo: planId).getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching days: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                    return
                }
                var days: [Day] = []
                let group = DispatchGroup()

                documents.forEach { document in
                    var day = Day(id: document.documentID, name: document.data()["name"] as? String ?? "No Name")
                    group.enter()
                    self.fetchDestinationsForDay(dayId: day.id!, completion: { destinations in
                        day.destinations = destinations
                        days.append(day)
                        group.leave()
                    })
                }

                group.notify(queue: .main) {
                    completion(days)
                }
            }
        }

        func fetchDestinationsForDay(dayId: String, completion: @escaping ([Destination]) -> Void) {
            db.collection("destinations").whereField("dayId", isEqualTo: dayId).getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching destinations: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                    return
                }
                let destinations = documents.map { document -> Destination in
                    return Destination(id: document.documentID, name: document.data()["name"] as? String ?? "No Name",rating: document.data()["rating"] as! String,isAddedToPlan: document.data()["isAddedToPlan"] as! Bool, imageBase64: document.data()["imageBase64"] as? String)
                }
                completion(destinations)
            }
        }
    func displayPlans() {
        print("Total plans loaded: \(plans.count)")
        for plan in plans {
            print("\nPlan ID: \(plan.id), Plan Name: \(plan.name)")
            for day in plan.days! {
                print("  Day ID: \(day.id), Day Name: \(day.name)")
                for destination in day.destinations! {
                    print("    Destination ID: \(destination.id), Destination Name: \(destination.name)")
                }
            }
        }
    }
//    @objc func dataDeleted() {
//            // Reload your table view
//        self.plansScreen.tableViewExpense.reloadData()
//    }

    @objc func handleDeletePlan(_ notification: Notification) {
        if let planId = notification.userInfo?["planId"] as? String {
            // Remove the plan with the specified ID from the plans array
            plans = plans.filter { $0.id != planId }
            // Reload the table view
            plansScreen.tableViewExpense.reloadData()
        }
    }
}



extension MyPlansViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfPlans = plans.count
        if numberOfPlans == 0 {
            //print("hi \(numberOfPlans)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "plans", for: indexPath) as! TableViewPlansCell
        cell.labelName.text = plans[indexPath.row].name
        if let uwDateFrom = plans[indexPath.row].dateFrom{
            if let uwDateTo = plans[indexPath.row].dateTo{
                
                //let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                
                let dateString = dateFormatter.string(from: uwDateFrom)
                let dateString2 = dateFormatter.string(from: uwDateTo)
                
                cell.labelDateTo.text = "\(dateString) - \(dateString2)"
            }
        }
        //let days = plans[indexPath.row].days?[0]
        let days = plans[indexPath.row].days
        if days!.count > 0 {
            let destinations = days?[0].destinations
            if destinations!.count > 0{
                if let base64String = destinations?[0].imageBase64 {
                            // Convert the base64 string to Data
                            if let imageData = Data(base64Encoded: base64String) {
                                print("Image Data Size: \(imageData.count)")
                                // Create UIImage from the data
                                if let image = UIImage(data: imageData) {
                                    // Set the image to the UIImageView
                                    cell.imageReceipt.image =  image
                        }
                    }
                }
            }
        }
        
        
            
        
        if let uwguest = plans[indexPath.row].guests{
            cell.labelPeople.text = "People: \(uwguest.count + 1)"
        }
        
       if let uwIsOwner = plans[indexPath.row].owner {
            if uwIsOwner == userId{
                cell.labelOwner.text = "Owner"
            } else{
                cell.labelOwner.text = ""
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showPlanDetailsController = ShowPlanDetailsViewController()
        showPlanDetailsController.receivedPlan = self.plans[indexPath.row]
        showPlanDetailsController.delegate = self
        navigationController?.pushViewController(showPlanDetailsController, animated: true)
        plansScreen.tableViewExpense.deselectRow(at: indexPath, animated: true)
    }
   
}

