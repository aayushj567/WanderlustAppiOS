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
    let firstScreen = FirstScreenView()
    
    var plans = [Plan]()
    
    var currentplan = Plan()
    let db = Firestore.firestore()
    
    let userId = Auth.auth().currentUser?.uid
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // super.viewDidLoad()
        title = "My Plans"
        
        firstScreen.tableViewExpense.delegate = self
        firstScreen.tableViewExpense.dataSource = self
        firstScreen.tableViewExpense.separatorColor = .clear
        firstScreen.tableViewExpense.separatorStyle = .none
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .add, target: self,
//            action: #selector(onAddBarButtonTapped)
//        )
//        getGuestPlans()
//        getPlans()
        fetchPlansForUser()
        displayPlans()
        firstScreen.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
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
                let chatView = ChatViewController()
                navigationController?.pushViewController(chatView, animated: true)
            }
            print("Icon at index \(index) was tapped.")
            if(index == 3)
            {
                let profileView = ShowProfileViewController()
                navigationController?.pushViewController(profileView, animated: true)
            }
        }
//        let newContact = Plan(id: 1, name: "No Limits", datefrom: "02/12", dateto:"02/31", people:"4", budget:"$2000", place:"New York" , image: (UIImage(systemName: "photo.fill"))!)
//        let newContact1 = Plan(id: 2, name: "Go France", datefrom: "04/24", dateto:"05/02", people:"4", budget:"$5000", place:"Paris", image: (UIImage(systemName: "photo.fill"))!)
//        let newContact2 = Plan(id: 3, name: "Be a Roman in Rome", datefrom: "06/30", dateto:"07/31", people:"10", budget:"$5500", place:"Italy", image: (UIImage(systemName: "photo.fill"))!)
        
//        contacts.append(newContact)
//        contacts.append(newContact1)
//        contacts.append(newContact2)
    }
    
    override func loadView() {
        view = firstScreen
        //getPlans()
       
    }
    
    func delegateOnAddContact(contact: Plan){
        plans.append(contact)
        firstScreen.tableViewExpense.reloadData()
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType: String, newImage: UIImage) {
        
        plans[idVal].name = newName
        
        firstScreen.tableViewExpense.reloadData()
    }
    
//    func getPlansDemo(){
//        let db = Firestore.firestore()
//        guard let currentUser = Auth.auth().currentUser else {
//                   fatalError("No user signed in")
//               }
//            do {
//                db.collection("plans").getDocuments { (querySnapshot, error) in
//                    if let error = error {
//                        print("Error getting documents: \(error)")
//                    } else {
////                        for document in querySnapshot!.documents {     //print(document.data()) // Check the entire structure
////                            if let plans = document.data()["plans"] as? [String: Any] {
////
////                                if let days = plans["days"] as? [[String: Any]] {  // 'days' should be an array of dictionaries
////                                    for day in days {         print(day)  // Debug: Print each 'day' dictionary
////                                        let name = day["name"] as? String  // Access the 'name' field
////                                        let destinations = day["destinations"] as? [String]  // Assuming 'destinations' is an array of strings
////                                        print("Name: \(name ?? "No name")")  // Debug: Print 'name'
////                                        print("Destinations: \(destinations ?? [])")  // Debug: Print 'destinations'
////                                    }     }
////                                        else {       print("Days data is not formatted correctly or is missing.")
////                                    }
////
////                                //print(plans) // Check the 'Plans' dictionary
//////                                let days = plans["days"] as? [Day]
//////                                //print(days)
//////                                print(days?[0].name)// Check 'days'
////                            } else {
////                                print("Plans is not correctly formatted or is missing.")
////                            }
////                        }
//                        for document in querySnapshot!.documents {
//                            let plans = document.data()["plans"] as? [Plan]
//                            //print(plans)
//                            let days = document.data()["days"] as? [Day]
//                           // print(days)
//                            //print(days[0].name)
//                            //let destinations = days[0].destinations
//                            //let destinations: [Destination]
//                            if let name = document.data()["name"] as? String,
//                               let owner = document.data()["owner"] as? String,
//                               let dateFrom = document.data()["dateFrom"] as? String,
//                               let dateTo = document.data()["dateTo"] as? String
//                              // let daydetails = days
//                               {
//                               //for day in daydetails{
//                                    //if let destinations = day.destinations{
//                                        //for dest in destinations{
//                                   //contacts[1].name = name;
////                                  print("Name: \(name), Owner: \(owner), datefrom: \(dateFrom), dateto: \(dateTo) ")
//
////                                print(name)
////                                print(owner)
////                                print(dateFrom)
////                                print(dateTo)
//                                var guests: [String] = []
//                                guests.append("2")
//                                guests.append("3")
//                                var dayslist: [Day] = []
//                                var destinationlist: [Destination] = []
//                                var desti = Destination(name:"Boston", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                destinationlist.append(desti)
//                                var day = Day(name:"Day 1", destinations: destinationlist)
//                                
//                                
//                                dayslist.append(day)
//                                let dateFormatter = DateFormatter()
//
//                                // Set the date format
//                                dateFormatter.dateFormat = "yyyy-MM-dd "
//
//                                // Convert Date to String
//                                let dateString = dateFormatter.date(from: dateFrom)
//                                let dateString2 = dateFormatter.date(from: dateTo)
////                                var newContact = Plan(name: name, dateFrom: dateString, dateTo:dateString2, days:dayslist, owner:"4", guests:guests)
////                                self.plans.append(newContact)
////                                print(newContact)
//                                        //}
//                                  //}
//                               //}
//                                
//
//                            }
//                        }
//                        self.firstScreen.tableViewExpense.reloadData()
//                    }
//                }
//            } catch let error {
//                print("Error serializing plan: \(error)")
//            }
//    }
//    
//    func getPlans(){
//                let db = Firestore.firestore()
//                let plansRef = db.collection("plans").whereField("owner", isEqualTo: userId)
//               // print("Enter into the function")
//                
//                plansRef.getDocuments { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        // Iterate over each plan document
//                        for planDocument in querySnapshot!.documents {
//                            do {
//                                // Try to decode the plan document into a Plan struct
//                                print("inside else")
//                                var plan = try planDocument.data(as: Plan.self)
//                                //print("Fetched plan: \(plan)")
//                                //print("PLAN DAYS: \(plan.days)")
//                                // Fetch the 'days' subcollection for the current plan
//                                planDocument.reference.collection("days").getDocuments { (daysSnapshot, daysErr) in
//                                    if let daysErr = daysErr {
//                                        print("Error getting days: \(daysErr)")
//                                    } else if let daysSnapshot = daysSnapshot {
//                                        do {
//                                            let days = try daysSnapshot.documents.compactMap {
//                                                try $0.data(as: Day.self)
//                                            }
//                                            plan.days = days
//                                            //for day in days{
//                                            print("Complete day data: \(days)")
//                                            //}
//                                            //print(plan.days![0].destinations)
//                                            //print("Complete plan data: \(plan)")
//                                        } catch {
//                                            print("Error decoding days: \(error)")
//                                        }
//                                    }
//                                }
//                                
//                                if let name = plan.name,
//                                   let owner = plan.owner,
//                                   let dateFrom = plan.dateFrom,
//                                   let dateTo = plan.dateTo {
//                                   
//                                    
//                                    var guests: [String] = []
//                                    guests.append("John Doe")
//                                    guests.append("Micheal Philips")
//                                    guests.append("Justin Beiber")
//                                    guests.append("Taylor Swift")
//                                    guests.append("Erri pukk Sai Sriker Reddy Vootukuri")
//                                    var dayslist: [Day] = []
//                                    var destinationlist: [Destination] = []
//                                    var desti = Destination(name:"Museum of Fine Arts", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti2 = Destination(name:"Boston Common", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti3 = Destination(name:"Harvard", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti4 = Destination(name:"Charles River", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti5 = Destination(name:"Duck Tour", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti6 = Destination(name:"Whale Waching", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti7 = Destination(name:"Castle Island", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti8 = Destination(name:"MIT", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    destinationlist.append(desti)
//                                    var destinationlist2: [Destination] = []
//                                    destinationlist2.append(desti2)
//                                    var destinationlist3: [Destination] = []
//                                    destinationlist3.append(desti3)
//                                    var destinationlist4: [Destination] = []
//                                    destinationlist4.append(desti4)
//                                    var destinationlist5: [Destination] = []
//                                    destinationlist5.append(desti5)
//                                    var destinationlist6: [Destination] = []
//                                    destinationlist6.append(desti6)
//                                    var destinationlist7: [Destination] = []
//                                    destinationlist7.append(desti7)
//                                    var destinationlist8: [Destination] = []
//                                    destinationlist8.append(desti8)
//                                    let day = Day(name:"Day 1", destinations: destinationlist)
//                                    let day1 = Day(name:"Day 2", destinations: destinationlist2)
//                                    let day2 = Day(name:"Day 3", destinations: destinationlist3)
//                                    let day3 = Day(name:"Day 4", destinations: destinationlist4)
//                                    let day4 = Day(name:"Day 5", destinations: destinationlist5)
//                                    let day5 = Day(name:"Day 6", destinations: destinationlist6)
//                                    let day6 = Day(name:"Day 7", destinations: destinationlist7)
//                                    let day7 = Day(name:"Day 8", destinations: destinationlist8)
//                                    
//                                    dayslist.append(day)
//                                    dayslist.append(day1)
//                                    dayslist.append(day2)
//                                    dayslist.append(day3)
//                                    dayslist.append(day4)
//                                    dayslist.append(day5)
//                                    dayslist.append(day6)
//                                    dayslist.append(day7)
//                           
////                                    var newPlan = Plan(name: name, dateFrom: dateFrom, dateTo:dateTo, days:dayslist, owner:"4", guests:guests, isOwner: true)
////                                    self.plans.append(newPlan)
//                                    //print(newPlan)
//                                }
//                            
//                            //self.firstScreen.tableViewExpense.reloadData()
//                                
//                            } catch {
//                                print("Error decoding plan: \(error)")
//                            }
//                        }
//                    }
//                }
//    }
//    
//    
//    func getGuestPlans(){
//                let db = Firestore.firestore()
//                let plansRef = db.collection("plans").whereField("guests", arrayContains: userId)
//               // print("Enter into the function")
//                
//                plansRef.getDocuments { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        // Iterate over each plan document
//                        for planDocument in querySnapshot!.documents {
//                            do {
//                                // Try to decode the plan document into a Plan struct
//                                print("inside else")
//                                var plan = try planDocument.data(as: Plan.self)
//                                //print("Fetched plan: \(plan)")
//                                print("PLAN DAYS: \(plan.days)")
//                                // Fetch the 'days' subcollection for the current plan
//                                planDocument.reference.collection("days").getDocuments { (daysSnapshot, daysErr) in
//                                    if let daysErr = daysErr {
//                                        print("Error getting days: \(daysErr)")
//                                    } else if let daysSnapshot = daysSnapshot {
//                                        do {
//                                            let days = try daysSnapshot.documents.compactMap {
//                                                try $0.data(as: Day.self)
//                                            }
//                                            plan.days = days
//                                            //for day in days{
//                                            print("Complete day data: \(days)")
//                                            //}
//                                            //print(plan.days![0].destinations)
//                                            //print("Complete plan data: \(plan)")
//                                        } catch {
//                                            print("Error decoding days: \(error)")
//                                        }
//                                    }
//                                }
//                                
//                                if let name = plan.name,
//                                   let owner = plan.owner,
//                                   let dateFrom = plan.dateFrom,
//                                   let dateTo = plan.dateTo {
//                                   
//                                    
//                                    var guests: [String] = []
//                                    guests.append("John Doe")
//                                    guests.append("Micheal Philips")
//                                    guests.append("Justin Beiber")
//                                    guests.append("Taylor Swift")
//                                    guests.append("Erri pukk Sai Sriker Reddy Vootukuri")
//                                    var dayslist: [Day] = []
//                                    var destinationlist: [Destination] = []
//                                    var desti = Destination(name:"Museum of Fine Arts", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti2 = Destination(name:"Boston Common", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti3 = Destination(name:"Harvard", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti4 = Destination(name:"Charles River", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti5 = Destination(name:"Duck Tour", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti6 = Destination(name:"Whale Waching", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti7 = Destination(name:"Castle Island", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    var desti8 = Destination(name:"MIT", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
//                                    destinationlist.append(desti)
//                                    var destinationlist2: [Destination] = []
//                                    destinationlist2.append(desti2)
//                                    var destinationlist3: [Destination] = []
//                                    destinationlist3.append(desti3)
//                                    var destinationlist4: [Destination] = []
//                                    destinationlist4.append(desti4)
//                                    var destinationlist5: [Destination] = []
//                                    destinationlist5.append(desti5)
//                                    var destinationlist6: [Destination] = []
//                                    destinationlist6.append(desti6)
//                                    var destinationlist7: [Destination] = []
//                                    destinationlist7.append(desti7)
//                                    var destinationlist8: [Destination] = []
//                                    destinationlist8.append(desti8)
//                                    let day = Day(name:"Day 1", destinations: destinationlist)
//                                    let day1 = Day(name:"Day 2", destinations: destinationlist2)
//                                    let day2 = Day(name:"Day 3", destinations: destinationlist3)
//                                    let day3 = Day(name:"Day 4", destinations: destinationlist4)
//                                    let day4 = Day(name:"Day 5", destinations: destinationlist5)
//                                    let day5 = Day(name:"Day 6", destinations: destinationlist6)
//                                    let day6 = Day(name:"Day 7", destinations: destinationlist7)
//                                    let day7 = Day(name:"Day 8", destinations: destinationlist8)
//                                    
//                                    dayslist.append(day)
//                                    dayslist.append(day1)
//                                    dayslist.append(day2)
//                                    dayslist.append(day3)
//                                    dayslist.append(day4)
//                                    dayslist.append(day5)
//                                    dayslist.append(day6)
//                                    dayslist.append(day7)
//                                    //dayslist.append(day1)
//                                   
//                                   
//                           
////                                    var newPlan = Plan(name: name, dateFrom: dateFrom, dateTo:dateTo, days:dayslist, owner:"4", guests:guests, isOwner: false)
//                                  //  self.plans.append(newPlan)
//                                    //print(newPlan)
//                                }
//                            
//                            self.firstScreen.tableViewExpense.reloadData()
//                                
//                            } catch {
//                                print("Error decoding plan: \(error)")
//                            }
//                        }
//                    }
//                }
//    }
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
                    var guests: [String] = []
                    
                    guests.append("John Doe")
                    guests.append("Micheal Philips")
                    guests.append("Justin Beiber")
                    guests.append("Taylor Swift")
                    guests.append("Sai Sriker Reddy Vootukuri")
                    
                    var plan = Plan(id: document.documentID, name: document.data()["name"] as? String ?? "No Name",dateFrom: dateFromTimestamp, dateTo: dateToTimestamp, owner: userId, guests:guests)
                    group.enter()
                    self?.fetchDaysForPlan(planId: plan.id!, completion: { days in
                        plan.days = days
                        self?.plans.append(plan)
                        group.leave()
                    })
                }
                self?.firstScreen.tableViewExpense.reloadData()
                group.notify(queue: .main) {
                    print("All plans have been fetched and structured.")
                    self?.displayPlans()
                    self?.firstScreen.tableViewExpense.reloadData()
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

}



extension MyPlansViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
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
        
//        if let uwIsOwner = plans[indexPath.row].isOwner {
//            if uwIsOwner{
        cell.labelOwner.text = "Owner"
//            }
//        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showPlanDetailsController = ShowPlanDetailsViewController()
        showPlanDetailsController.receivedPlan = self.plans[indexPath.row]
        showPlanDetailsController.delegate = self
        navigationController?.pushViewController(showPlanDetailsController, animated: true)
        firstScreen.tableViewExpense.deselectRow(at: indexPath, animated: true)
    }
   
}

