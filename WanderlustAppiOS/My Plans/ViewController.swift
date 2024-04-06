//
//  ViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ViewController: UIViewController {
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
        firstScreen.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
        }
        let newContact = Plan(id: 1, name: "No Limits", datefrom: "02/12", dateto:"02/31", people:"4", budget:"$2000", place:"New York" , image: (UIImage(systemName: "photo.fill"))!)
        let newContact1 = Plan(id: 2, name: "Go France", datefrom: "04/24", dateto:"05/02", people:"4", budget:"$5000", place:"Paris", image: (UIImage(systemName: "photo.fill"))!)
        let newContact2 = Plan(id: 3, name: "Be a Roman in Rome", datefrom: "06/30", dateto:"07/31", people:"10", budget:"$5500", place:"Italy", image: (UIImage(systemName: "photo.fill"))!)
        
        contacts.append(newContact)
        contacts.append(newContact1)
        contacts.append(newContact2)
    }
    
    override func loadView() {
        view = firstScreen
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
        contacts[idVal].datefrom = newEmail
        contacts[idVal].dateto = newPhone
        contacts[idVal].budget = newCity
        contacts[idVal].place = newZip
        contacts[idVal].people = newAddress
        contacts[idVal].image = newImage
        contacts[idVal].type = newType
        
        firstScreen.tableViewExpense.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewContactsCell
        cell.labelName.text = contacts[indexPath.row].name
        if let uwEmail = contacts[indexPath.row].datefrom{
            if let uwPhone = contacts[indexPath.row].dateto{
                cell.labelDateTo.text = "Dates: \(uwPhone) - \(uwEmail)"
            }
        }
        
        if let uwAddress = contacts[indexPath.row].people{
            cell.labelPeople.text = "People: \(uwAddress)"
        }
        if let uwZip = contacts[indexPath.row].place{
            cell.labelPlace.text = "Place: \(uwZip)"
        }
        if let uwImage = contacts[indexPath.row].image{
            cell.imageReceipt.image = uwImage
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let showContactController = ShowContactViewController()
        showContactController.receivedContact = self.contacts[indexPath.row]
        showContactController.delegate = self
        navigationController?.pushViewController(showContactController, animated: true)
        firstScreen.tableViewExpense.deselectRow(at: indexPath, animated: true)
    }
    
   
}

