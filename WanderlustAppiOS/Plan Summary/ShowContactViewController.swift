//
//  ViewContactViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ShowContactViewController: UIViewController {
    
    let displayPlanSummary = ShowContactView()
    var delegate:MyPlansViewController!
    
    override func loadView() {
        view = displayPlanSummary
        title = "Plan Summary"
    }
    
    var receivedContact: Plan = Plan()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let unwrappedName = receivedContact.name{
            if !unwrappedName.isEmpty{
                displayPlanSummary.labelName.text = "\(unwrappedName)"
            }
        }
//        if let unwrappedEmail = receivedContact.dateFrom{
//            if !unwrappedEmail.isEmpty{
//                displayPlanSummary.labelDateFrom.text = "Date from: \(unwrappedEmail)"
//            }
//        }
//        if let unwrappedPhone = receivedContact.dateTo{
//            if !unwrappedPhone.isEmpty{
//                //if let unwrappedType = receivedContact.type{
//                   // if !unwrappedType.isEmpty{
//                        displayPlanSummary.labelDateTo.text = "Date to: \(unwrappedPhone)"
//                   // }
//                //}
//            }
//        }
//        if let unwrappedAddress = receivedContact.people{
//            if !unwrappedAddress.isEmpty{
//                displayPlanSummary.labelPeople.text = "People:"
//                displayPlanSummary.labelTravelPeople.text = "John Doe, Micheal Philips, Justin Beiber"
//            }
//        }
        
//        displayPlanSummary.labelItenerary.text = "Itinerary:"
//        displayPlanSummary.labelIteneraryData.text = "Day 1: Empire State Building"
//        if let unwrappedCity = receivedContact.budget{
//            if !unwrappedCity.isEmpty{
//                displayPlanSummary.labelBudget.text = "Estimated budget: \(unwrappedCity)"
//            }
//        }
//        if let unwrappedZip = receivedContact.place{
//            if !unwrappedZip.isEmpty{
//                displayPlanSummary.labelPlace.text = "Place: \(unwrappedZip)"
//            }
//        }
//        if let unwrappedImage = receivedContact.image{
//            displayPlanSummary.imageView.image = unwrappedImage
//        }
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .edit,
//            target: self,
//            action: #selector(onEditButtonTapped)
//        )
    }
    
//    @objc func onEditButtonTapped(){
//        
//        let addContactController = AddContactViewController()
//        
//        addContactController.delegateshow = self
//        addContactController.addContactView.textFieldName.text = receivedContact.name
//        addContactController.addContactView.textFieldEmail.text = receivedContact.datefrom
//        addContactController.addContactView.textFieldPhone.text = receivedContact.dateto
//        addContactController.addContactView.textFieldAddress.text = receivedContact.people
//        addContactController.addContactView.textFieldZip.text = receivedContact.place
//        addContactController.addContactView.textFieldCity.text = receivedContact.budget
//        addContactController.pickedImage = receivedContact.image
//        addContactController.addContactView.buttonSelectType.setTitle(receivedContact.type, for: .normal)
//        addContactController.selectedType = receivedContact.type
//        addContactController.currentid = receivedContact.id
//        addContactController.isEdit = true
//        
//        var viewControllers = navigationController?.viewControllers ?? []
//        if let index = viewControllers.lastIndex(where: { $0 is ShowContactViewController }) {
//            viewControllers[index] = addContactController
//        }
//        navigationController?.setViewControllers(viewControllers, animated: true)
//    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
    }
}
