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
    
    var contacts = [Plan]()
    
    var currentcontact = Plan()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        title = "My Plans"
        
        firstScreen.tableViewExpense.delegate = self
        firstScreen.tableViewExpense.dataSource = self
        firstScreen.tableViewExpense.separatorColor = .clear
        firstScreen.tableViewExpense.separatorStyle = .none
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .add, target: self,
//            action: #selector(onAddBarButtonTapped)
//        )
        getPlans()
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
        getPlans()

    }
    
//    @objc func onAddBarButtonTapped(){
//        let addExpenseController = AddContactViewController()
//        addExpenseController.delegate = self
//        addExpenseController.contacts = contacts
//        navigationController?.pushViewController(addExpenseController, animated: true)
//    }
    
    func delegateOnAddContact(contact: Plan){
        contacts.append(contact)
        firstScreen.tableViewExpense.reloadData()
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType: String, newImage: UIImage) {
        
        contacts[idVal].name = newName
//        contacts[idVal].dateFrom = newEmail
//        contacts[idVal].dateTo = newPhone
        //contacts[idVal].budget = newCity
        //contacts[idVal].place = newZip
       // contacts[idVal].guests = newAddress
    //contacts[idVal].image = newImage
       // contacts[idVal].type = newType
        
        firstScreen.tableViewExpense.reloadData()
    }
    
    func getPlans(){
        let db = Firestore.firestore()
        guard let currentUser = Auth.auth().currentUser else {
                   fatalError("No user signed in")
               }
            do {
                db.collection("plans").getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        
                        for document in querySnapshot!.documents {
                           // let days = document.data()["days"] as? [Day]
                            //print(days[0].name)
                            //let destinations = days[0].destinations
                            //let destinations: [Destination]
                            if let name = document.data()["name"] as? String,
                               let owner = document.data()["owner"] as? String,
                               let dateFrom = document.data()["dateFrom"] as? String,
                               let dateTo = document.data()["dateTo"] as? String
                              // let daydetails = days
                               {
                               //for day in daydetails{
                                    //if let destinations = day.destinations{
                                        //for dest in destinations{
                                   //contacts[1].name = name;
//                                  print("Name: \(name), Owner: \(owner), datefrom: \(dateFrom), dateto: \(dateTo) ")

                               
                                var guests: [String] = []
                                guests.append("2")
                                guests.append("3")
                                var dayslist: [Day] = []
                                var destinationlist: [Destination] = []
                                var desti = Destination(name:"Boston", rating:"4,3", admissionPrice:"$30", isAddedToPlan: false, placeId:"1", photoReference:"XXZZXXZX", imageBase64:"HELLO", duration:"24")
                                destinationlist.append(desti)
                                var day = Day(name:"Day 1", destinations: destinationlist)
                                
                                
                                dayslist.append(day)
                                let dateFormatter = DateFormatter()

                                // Set the date format
                                dateFormatter.dateFormat = "yyyy-MM-dd "

                                // Convert Date to String
                                let dateString = dateFormatter.date(from: dateFrom)
                                let dateString2 = dateFormatter.date(from: dateTo)
                                var newContact = Plan(name: name, dateFrom: dateString, dateTo:dateString2, days:dayslist, owner:"4", guests:guests)
                                self.contacts.append(newContact)
                                print(newContact)
                                        //}
                                  //}
                               //}
                                

                            }
                        }
                        self.firstScreen.tableViewExpense.reloadData()
                    }
                }
            } catch let error {
                print("Error serializing plan: \(error)")
            }
    }
}


extension MyPlansViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewContactsCell
        cell.labelName.text = contacts[indexPath.row].name
        if let uwEmail = contacts[indexPath.row].dateFrom{
            if let uwPhone = contacts[indexPath.row].dateTo{
                cell.labelDateTo.text = "Dates: \(uwPhone) - \(uwEmail)"
            }
        }
        
        if let uwAddress = contacts[indexPath.row].guests{
            cell.labelPeople.text = "People: \(uwAddress)"
        }
        if let uwZip = contacts[indexPath.row].days{
            cell.labelPlace.text = "Place: \(uwZip)"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showContactController = ShowPlanDetailsViewController()
        showContactController.receivedContact = self.contacts[indexPath.row]
        showContactController.delegate = self
        navigationController?.pushViewController(showContactController, animated: true)
        firstScreen.tableViewExpense.deselectRow(at: indexPath, animated: true)
    }
   
}

