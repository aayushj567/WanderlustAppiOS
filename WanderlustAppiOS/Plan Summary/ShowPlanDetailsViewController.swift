//
//  ViewContactViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShowPlanDetailsViewController: UIViewController {
    
    let displayPlanSummary = ShowPlanDetailsView()
    var delegate:MyPlansViewController!
    
    var receivedPlan: Plan = Plan()
    var dayWise = [Day]()
    var people = ""
    
    let db = Firestore.firestore()

    let userId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(receivedPlan)
        //let sortedarrays = receivedPlan.days.sort { $0.name < $1.name }
        if var days = receivedPlan.days{
            days.sort { $0.name < $1.name }
            dayWise = days
        }
        displayPlanSummary.tableViewExpense.delegate = self
        displayPlanSummary.tableViewExpense.dataSource = self
        displayPlanSummary.tableViewExpense.separatorColor = .clear
        displayPlanSummary.tableViewExpense.separatorStyle = .none
        displayPlanSummary.tableViewExpense.reloadData()

        
        if let unwrappedName = receivedPlan.name{
            if !unwrappedName.isEmpty{
                title = "\(unwrappedName)"
            }
        }
        
        if let unwrappedDateFrom = receivedPlan.dateFrom{
            if let unwrappedDateTo = receivedPlan.dateTo{
                displayPlanSummary.labelDate.text = "Dates:"

                var durationInDays = durationInDays(from: unwrappedDateFrom, to: unwrappedDateTo)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                    
                
                
                let dateString = dateFormatter.string(from: unwrappedDateFrom)
                let dateString2 = dateFormatter.string(from: unwrappedDateTo)
                let days = durationInDays == 1 ? "day" : "days"
                   displayPlanSummary.labelDates.text = "\(dateString) - \(dateString2) (\(durationInDays) \(days))"
            }
             
        }
        
        if let unwrappedGuests = receivedPlan.guests{
            if !unwrappedGuests.isEmpty{
                displayPlanSummary.labelPeople.text = "People:"
                displayPlanSummary.labelTravelPeople.text = "\(unwrappedGuests.count + 1)"
            }
        }
        var dayNames = ""
        if let unwrappedDays = receivedPlan.days{
            displayPlanSummary.labelItenerary.text = "Itinerary:"

        }
        if let owner = receivedPlan.owner{
            if owner == userId {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .edit,
                    target: self,
                    action: #selector(onDeletePlan)
                )
            }
        }
            db.collection("users").whereField("id", isEqualTo: receivedPlan.owner!).getDocuments { [weak self] (snapshot, error) in
                guard let userdocuments = snapshot?.documents else {
                    print("Error fetching plans: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                userdocuments.forEach { document in
                   // var guest = (document.data()["name"] as? String ?? "")
                    self?.people += "\n\(document.data()["name"] as? String ?? "") (Owner)"
                }
            }
            
        
        if let unwrappedGuest = receivedPlan.guests {
            for guest in unwrappedGuest{
                db.collection("users").whereField("id", isEqualTo: guest).getDocuments { [weak self] (snapshot, error) in
                    guard let userdocuments = snapshot?.documents else {
                        print("Error fetching plans: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    userdocuments.forEach { document in
                        var guest = (document.data()["name"] as? String ?? "")
                        self?.people += "\n\(guest)\n"
                    }
                }
                
            }
        }
        
        displayPlanSummary.deletePlan.addTarget(self, action: #selector(onDeletePlan), for: .touchUpInside)
        displayPlanSummary.showPeople.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
       
    }
    
    override func loadView() {
        view = displayPlanSummary
    }
    
   @objc func onEditButtonTapped(){
       
//        let addContactController = AddContactViewController()
//        
//        addContactController.delegateshow = self
//        addContactController.addContactView.textFieldName.text = receivedPlan.name
//        addContactController.addContactView.textFieldEmail.text = receivedPlan.datefrom
//        addContactController.addContactView.textFieldPhone.text = receivedPlan.dateto
//        addContactController.addContactView.textFieldAddress.text = receivedPlan.people
//        addContactController.addContactView.textFieldZip.text = receivedPlan.place
//        addContactController.addContactView.textFieldCity.text = receivedPlan.budget
//        addContactController.pickedImage = receivedPlan.image
//        addContactController.addContactView.buttonSelectType.setTitle(receivedPlan.type, for: .normal)
//        addContactController.selectedType = receivedPlan.type
//        addContactController.currentid = receivedPlan.id
//        addContactController.isEdit = true
//        
//        var viewControllers = navigationController?.viewControllers ?? []
//        if let index = viewControllers.lastIndex(where: { $0 is ShowContactViewController }) {
//            viewControllers[index] = addContactController
//        }
//        navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
    }
    
    func durationInDays(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        let daysDifference = (components.day ?? 0) + 1
        return max(daysDifference, 1)
    }
    
    @objc func showAlert() {
          //  var people = ""

           
        let alertController = UIAlertController(title: "People", message: self.people, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("OK button tapped")
            }

            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
    }
    
    @objc func onDeletePlan(){
        print("on delete plan")
        print("Plan id coming: \(receivedPlan.id)")
        
        
        
        let db = Firestore.firestore()
        
        if let days = receivedPlan.days{
            for day in days{
               if let destinations = day.destinations{
                    for des in destinations{
                        let destRef = db.collection("destinations").document(des.id!)
                        destRef.delete { error in
                            if let error = error {
                                print("Error deleting document: \(error.localizedDescription)")
                            } else {
                                print("Document successfully deleted")
                            }
                        }
                    }
                }
                let dayRef = db.collection("days").document(day.id!)
                dayRef.delete { error in
                    if let error = error {
                        print("Error deleting document: \(error.localizedDescription)")
                    } else {
                        print("Document successfully deleted")
                    }
                }
            }
        }
        

        let planRef = db.collection("plans").document(receivedPlan.id!)

        planRef.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted")
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("DataDeleted"), object: nil)

        navigationController?.popViewController(animated: true)
    }
}

extension ShowPlanDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //if let days = receivedPlan.days {
            //print("daysdscdscwsdc \(dayWise.count) ")
            return dayWise.count
        //}
        //return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinerary", for: indexPath) as! TableViewItineraryCell
        print("test")
        
           // print("test")
           // print(days)
        cell.labelDayName.text = dayWise[indexPath.row].name
        
        var desti = ""
       // if let destinations = dayWise
        let day = dayWise[indexPath.row]
                // Using newline to separate destination names instead of commas
                let destinationDetails = day.destinations?.map { "\($0.name)" }.joined(separator: "\n") ?? "No destinations available"
         
                    cell.labelDestinationName?.text = "\(destinationDetails)"
                    cell.labelDestinationName?.numberOfLines = 0
        for dest in dayWise[indexPath.row].destinations!{
            desti += "\(dest.name)\n"
            //print("Base64 String: \(dest.imageBase64)")

            if let base64String = dest.imageBase64 {
                        // Convert the base64 string to Data
                        if let imageData = Data(base64Encoded: base64String) {
                            //print("Image Data Size: \(imageData.count)")
                            // Create UIImage from the data
                            if let image = UIImage(data: imageData) {
                                // Set the image to the UIImageView
                                cell.imageReceipt.image =  image
                            }
                        }
                    }
        }
        //cell.labelDestinationName.text = desti
        
       
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            displayPlanSummary.tableViewExpense.deselectRow(at: indexPath, animated: true)
    }
   
}
