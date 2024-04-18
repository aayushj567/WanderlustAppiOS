import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI
import FirebaseStorage

class EditProfileViewController: UIViewController {
    
    let editProfileScreen = RegistrationView()
    // INstance of Firestore database
    let db = Firestore.firestore()
    //create a Firebase Storage instance
    let storage = Storage.storage()
    //variable to store the picked Image...
    var pickedImage:UIImage?
    
    override func loadView() {
        view = editProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        // added transparency to background
        editProfileScreen.backgroundImage.alpha = 0.3
        editProfileScreen.textFieldPassword.isHidden = true
        fillCurrentDetails()
        editProfileScreen.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        editProfileScreen.buttonTakePhoto.menu = getMenuImagePicker()
    }
    
    func fillCurrentDetails() {
        print("Filling details")
        // editing the titles of buttons and labels from registartion screen
        editProfileScreen.labelTitle.text = "Edit your details"
        editProfileScreen.labelPhoto.text = "Choose image"
        editProfileScreen.buttonRegister.setTitle("Save changes", for: .normal)
        editProfileScreen.textFieldPassword.text = "ENTER YOUR NEW PASSWORD..."
        
        // Check if a user is currently signed in
        if let currentUser = Auth.auth().currentUser {
            // if user is signed in load thir image
            if let imageURL = currentUser.photoURL {
                editProfileScreen.buttonTakePhoto.loadRemoteImage(from: imageURL)
            }
            // then load their name and emails
            let name = currentUser.displayName
            let email = currentUser.email
            editProfileScreen.textFieldName.text = "\(name ?? "N/A")"
            editProfileScreen.textFieldEmail.text = "\(email ?? "N/A")"
        }
    }
    
    //MARK: action to perform when Save Chnages button is tapped...
    @objc func onRegisterTapped(){
        // gathering data from text fields and making sure they are not empty
        guard let nameText = editProfileScreen.textFieldName.text, !nameText.isEmpty,
              let emailText = editProfileScreen.textFieldEmail.text, !emailText.isEmpty,
              let passwordText = editProfileScreen.textFieldPassword.text, !passwordText.isEmpty
        else {
            showAlert(message: "Please fill out all required fields.")
            return
        }
        // validating the enetered email
        guard isValidEmail(emailText) else {
            showAlert(message: "Invalid email. Please enter a valid email address.")
            return
        }
        // start the editing process in Firebase...
        wasEmailOrPasswordEdited()
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: menu for buttonTakePhoto setup...
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            }),
            UIAction(title: "Delete photo", attributes: .destructive, handler: { (_) in self.deleteButtonTapped()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    //MARK: pick Photo using Gallery...
    func deleteButtonTapped(){
        //MARK: Delete photo from Firebase...
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
//    func showRegistrationSuccessAlert() {
//        let alert = UIAlertController(title: "Success", message: "Registration successful. Please log in.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//            self.sendUserToLoginScreen()
//        })
//        present(alert, animated: true, completion: nil)
//    }
    
//    func sendUserToLoginScreen() {
//        loginScreenDelegate.hasCompletedRegistration = true
//        navigationController?.popViewController(animated: true)
//    }
}


