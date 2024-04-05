//
//  ViewContactViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit

class ShowContactViewController: UIViewController {
    
    let displayPlanSummary = ShowContactView()
    var delegate:ViewController!
    
    override func loadView() {
        view = displayPlanSummary
        title = "Plan Summary"
    }
    
    var receivedContact: Contact = Contact()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let unwrappedName = receivedContact.name{
            if !unwrappedName.isEmpty{
                displayPlanSummary.labelName.text = "Plan Name: \(unwrappedName)"
            }
        }
        if let unwrappedEmail = receivedContact.email{
            if !unwrappedEmail.isEmpty{
                displayPlanSummary.labelEmail.text = "Date from: \(unwrappedEmail)"
            }
        }
        if let unwrappedPhone = receivedContact.phone{
            if !unwrappedPhone.isEmpty{
                //if let unwrappedType = receivedContact.type{
                   // if !unwrappedType.isEmpty{
                        displayPlanSummary.labelPhone.text = "Date to:   \(unwrappedPhone)"
                   // }
                //}
            }
        }
        if let unwrappedAddress = receivedContact.address{
            if !unwrappedAddress.isEmpty{
                displayPlanSummary.labelAddressHeading.text = "People:"
                displayPlanSummary.labelAddress.text = "\(unwrappedAddress)"
            }
        }
        if let unwrappedCity = receivedContact.city{
            if !unwrappedCity.isEmpty{
                displayPlanSummary.labelCity.text = "Estimated budget: \(unwrappedCity)"
            }
        }
//        if let unwrappedZip = receivedContact.zip{
//            if !unwrappedZip.isEmpty{
//                displayPlanSummary.labelZip.text = "\(unwrappedZip)"
//            }
//        }
        if let unwrappedImage = receivedContact.image{
            displayPlanSummary.imageView.image = unwrappedImage
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(onEditButtonTapped)
        )
    }
    
    @objc func onEditButtonTapped(){
        
        let addContactController = AddContactViewController()
        
        addContactController.delegateshow = self
        addContactController.addContactView.textFieldName.text = receivedContact.name
        addContactController.addContactView.textFieldEmail.text = receivedContact.email
        addContactController.addContactView.textFieldPhone.text = receivedContact.phone
        addContactController.addContactView.textFieldAddress.text = receivedContact.address
        addContactController.addContactView.textFieldZip.text = receivedContact.zip
        addContactController.addContactView.textFieldCity.text = receivedContact.city
        addContactController.pickedImage = receivedContact.image
        addContactController.addContactView.buttonSelectType.setTitle(receivedContact.type, for: .normal)
        addContactController.selectedType = receivedContact.type
        addContactController.currentid = receivedContact.id
        addContactController.isEdit = true
        
        var viewControllers = navigationController?.viewControllers ?? []
        if let index = viewControllers.lastIndex(where: { $0 is ShowContactViewController }) {
            viewControllers[index] = addContactController
        }
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
    }
}
