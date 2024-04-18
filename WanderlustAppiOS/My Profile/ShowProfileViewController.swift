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
            }
            // and load their name and emails
            let name = currentUser.displayName
            let email = currentUser.email
            displayScreen.labelName.text = "\(name ?? "N/A")"
            displayScreen.labelEmail.text = "Email: \(email ?? "N/A")"
        }
        
        //MARK: Creating a settings button with drop down menu...
        // create the drop down menu buttons and their action
         var menuItems: [UIAction] {
             return [
                UIAction(title: "Edit Profile", handler: { (_) in self.onEditButtonTapped()}),
                UIAction(title: "Change Password", handler: { (_) in self.onChangePasswordButtonTapped()}),
                UIAction(title: "Log out", attributes: .destructive, handler: { (_) in self.logoutButtonTapped()})
             ]
         }
        
         var profileMenu: UIMenu {
             return UIMenu(image: nil, identifier: nil, options: [], children: menuItems)
         }
        // creating the settings button at the top right bar.
         let settingsImage = UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysOriginal)
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: settingsImage, primaryAction: nil, menu: profileMenu)
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        
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
        let editScreen = EditProfileViewController()
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(editScreen, animated: true)
    }
    
    @objc func onChangePasswordButtonTapped(){
        print("changin password...")
    }
    
//    func delegateOnEditContact(idVal: Int, newName: String, newEmail: String, newPhone:String, newAddress:String, newCity:String, newZip:String, newType:String, newImage: UIImage) {
//        delegate.delegateOnEditContact(idVal: idVal, newName: newName, newEmail: newEmail, newPhone: newPhone, newAddress: newAddress, newCity: newCity, newZip: newZip, newType: newType, newImage: newImage)
//    }
}

