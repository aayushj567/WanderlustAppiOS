import UIKit
 
class ShowProfileViewController: UIViewController {
    
    let displayScreen = ShowContactView()
    var delegate:ViewController!
    
    override func loadView() {
        view = displayScreen
    }
    
    var receivedContact: Contact = Contact()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let unwrappedName = receivedContact.name{
            if !unwrappedName.isEmpty{
                displayScreen.labelName.text = "\(unwrappedName)"
            }
        }
        if let unwrappedEmail = receivedContact.email{
            if !unwrappedEmail.isEmpty{
                displayScreen.labelEmail.text = "Email: \(unwrappedEmail)"
            }
        }
        if let unwrappedPhone = receivedContact.phone{
            if !unwrappedPhone.isEmpty{
                if let unwrappedType = receivedContact.type{
                    if !unwrappedType.isEmpty{
                        displayScreen.labelPhone.text = "Phone: \(unwrappedPhone) (\(unwrappedType))"
                    }
                }
            }
        }
        if let unwrappedAddress = receivedContact.address{
            if !unwrappedAddress.isEmpty{
                displayScreen.labelAddressHeading.text = "Address:"
                displayScreen.labelAddress.text = "\(unwrappedAddress)"
            }
        }
        if let unwrappedCity = receivedContact.city{
            if !unwrappedCity.isEmpty{
                displayScreen.labelCity.text = "\(unwrappedCity)"
            }
        }
        if let unwrappedZip = receivedContact.zip{
            if !unwrappedZip.isEmpty{
                displayScreen.labelZip.text = "\(unwrappedZip)"
            }
        }
        if let unwrappedImage = receivedContact.image{
            displayScreen.imageView.image = unwrappedImage
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
