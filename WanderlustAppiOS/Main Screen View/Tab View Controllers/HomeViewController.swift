//
//  ViewController.swift
//  WA5_Jaiswal_6534
//
//  Created by Aayush Jaiswal on 2/17/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let firstScreen = HomeView()
    
    //MARK: contacts array to populate TableView...
    var contacts = [ContactInfo]()
    
    //MARK: predefined types of contacts...
    let phoneTypes = ["Work", "Home", "Cell"]
    
    override func loadView() {
        view = firstScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Plans"
        
        //MARK: manipulating TableView separator line...
        firstScreen.contactsTableView.separatorStyle = .none
        
        //MARK: patching the table view delegate and datasource to controller...
        firstScreen.contactsTableView.delegate = self
        firstScreen.contactsTableView.dataSource = self
        
        //MARK: setting the add button to the navigation controller...
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
    }
    
    @objc func onAddBarButtonTapped(){
        let addPlanVC = CalendarViewController()
        //addContaaddPlanVCctController.delegate = self
        navigationController?.pushViewController(addPlanVC, animated: true)
    }
    
    //MARK: got the new contact back and delegated to ViewController...
    func delegateOnAddContact(_ newContact: ContactInfo){
        contacts.append(newContact)
        firstScreen.contactsTableView.reloadData()
    }
    
    //MARK: got the updated contact back and delegated to ViewController...
    func delegateOnUpdateContact(_ newContact: ContactInfo, _ index: Int){
        contacts[index] = newContact
        firstScreen.contactsTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Plan info", for: indexPath) as! PlansTableViewCell
        
        cell.nameLabel.text = contacts[indexPath.row].name
        
        if let uwEmail = contacts[indexPath.row].email{
            cell.emailLabel.text = "Email: \(uwEmail)"
        }
        if let uwPhone = contacts[indexPath.row].phone, let uwPhoneType = contacts[indexPath.row].phoneType{
            cell.phoneLabel.text = "Phone: \(uwPhone) (\(uwPhoneType))"
        }
        //MARK: setting the image of the receipt...
        if let uwImage = contacts[indexPath.row].image{
            cell.contactPhoto.image = uwImage
        }
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailsViewController = ContactDetailsViewController()
//        detailsViewController.delegate = self
//        detailsViewController.currentContact = self.contacts[indexPath.row]
//        detailsViewController.currentContactIndex = indexPath.row
//        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

