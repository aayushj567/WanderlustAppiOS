//
//  ViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ViewController: UIViewController {
    let firstScreen = FirstScreenView()
    
    var contacts = [Contact]()
    
    var currentcontact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        title = "My Plans"
        
        firstScreen.tableViewExpense.delegate = self
        firstScreen.tableViewExpense.dataSource = self
        firstScreen.tableViewExpense.separatorColor = .clear
        firstScreen.tableViewExpense.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
        
        let newContact = Contact(id: 1, name: "No Limits", email: "02/12", phone:"02/31", address:"4", city:"$2000", zip:"New York" , image: (UIImage(systemName: "photo.fill"))!)
        let newContact1 = Contact(id: 2, name: "Go France", email: "04/24", phone:"05/02", address:"4", city:"$5000", zip:"Paris", image: (UIImage(systemName: "photo.fill"))!)
        let newContact2 = Contact(id: 3, name: "Be a Roman in Rome", email: "06/30", phone:"07/31", address:"10", city:"$5500", zip:"Italy", image: (UIImage(systemName: "photo.fill"))!)
        
        contacts.append(newContact)
        contacts.append(newContact1)
        contacts.append(newContact2)
    }
    
    override func loadView() {
        view = firstScreen
    }
    
    @objc func onAddBarButtonTapped(){
        let addExpenseController = AddContactViewController()
        addExpenseController.delegate = self
        addExpenseController.contacts = contacts
        navigationController?.pushViewController(addExpenseController, animated: true)
    }
    
    func delegateOnAddContact(contact: Contact){
        contacts.append(contact)
        firstScreen.tableViewExpense.reloadData()
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType: String, newImage: UIImage) {
        
        contacts[idVal].name = newName
        contacts[idVal].email = newEmail
        contacts[idVal].phone = newPhone
        contacts[idVal].city = newCity
        contacts[idVal].zip = newZip
        contacts[idVal].address = newAddress
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
        if let uwEmail = contacts[indexPath.row].email{
            if let uwPhone = contacts[indexPath.row].phone{
                cell.labelPhone.text = "Dates: \(uwPhone) - \(uwEmail)"
            }
        }
        
        if let uwAddress = contacts[indexPath.row].address{
            cell.labelAddress.text = "People: \(uwAddress)"
        }
        if let uwZip = contacts[indexPath.row].zip{
            cell.labelZip.text = "Place: \(uwZip)"
        }
//        if let uwCity = contacts[indexPath.row].city{
//            cell.labelCity.text = "Budget: \(uwCity)"
//        }
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

