import UIKit
import FirebaseAuth
 
class ShowProfileViewController: UIViewController {
    
    let displayScreen = ShowProfileView()
    var delegate:ViewController!
    
    override func loadView() {
        view = displayScreen
    }
    
    var receivedContact: Contact = Contact(id: 1,
                                           name: "John Doe",
                                           email: "johndoe@example.com",
                                           phone: "+1234567890",
                                           address: "123 Main Street",
                                           city: "Anytown",
                                           zip: "12345",
                                           type: "Home",
                                           image: UIImage(named: "profile_image"))
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
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .logout,
//            target: self,
//            action: #selector(onEditButtonTapped)
//        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
    }
    
    @objc func onLogOutBarButtonTapped(){

    }
    
    @objc func logout() {
        
        let logoutAlert = UIAlertController(title: "Log out?", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    @objc func onEditButtonTapped(){
        
        let addContactController = EditProfileController()
        
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
    
//    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
//        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
//    }
}
