import UIKit
import FirebaseAuth
 
class ShowProfileViewController: UIViewController {
    
    let displayScreen = ShowProfileView()
    var delegate:ViewController!
    
    override func loadView() {
        view = displayScreen
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Check if a user is currently signed in
        if let currentUser = Auth.auth().currentUser {
            // if user is signed in load thir image
            if let imageURL = currentUser.photoURL {
                displayScreen.imageView.loadRemoteImage(from: imageURL)
            } else {}
            // and load their name and emails
            let name = currentUser.displayName
            let email = currentUser.email
            displayScreen.labelName.text = "\(name ?? "N/A")"
            displayScreen.labelEmail.text = "Email: \(email ?? "N/A")"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        
    }
    
    @objc func logoutButtonTapped() {
        
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
        
        //let addContactController = EditProfileController()
    }
    
//    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
//        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
//    }
}
