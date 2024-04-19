//
//  ViewController.swift
//  WA6_Basu_7118
//
//  Created by Anwesa Basu on 25/02/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI
import FirebaseStorage

class RegistrationViewController: UIViewController {
    
    let registrationScreen = RegistrationView()
    var loginScreenDelegate:ViewController!
    // INstance of Firestore database
    let db = Firestore.firestore()
    //create a Firebase Storage instance
    let storage = Storage.storage()
    //variable to store the picked Image...
    var pickedImage:UIImage?
    
    override func loadView() {
        view = registrationScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
        registrationScreen.backgroundImage.alpha = 0.3
        registrationScreen.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        registrationScreen.buttonTakePhoto.menu = getMenuImagePicker()
    }
    
    //MARK: action to perform when registration button is tapped...
    @objc func onRegisterTapped(){
        // gathering data from text fields and making sure they are not empty
        guard let nameText = registrationScreen.textFieldName.text, !nameText.isEmpty,
              let emailText = registrationScreen.textFieldEmail.text, !emailText.isEmpty,
              let passwordText = registrationScreen.textFieldPassword.text, !passwordText.isEmpty
        else {
            showAlert(message: "Please fill out all required fields.")
            return
        }
        // validating the enetered email
        guard isValidEmail(emailText) else {
            showAlert(message: "Invalid email. Please enter a valid email address.")
            return
        }
        guard isPasswordValid(passwordText) else {
            showAlert(message: "Invalid password. Password should be atleast of 6 characters long.")
            return
        }
        // start the registration process by first uploading the picture...
        uploadProfilePhotoToStorage()
    }
    func isPasswordValid(_ password: String) -> Bool {
        return password.count >= 6
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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showRegistrationSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Registration successful. Please log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.sendUserToLoginScreen()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func sendUserToLoginScreen() {
        loginScreenDelegate.hasCompletedRegistration = true
        navigationController?.popViewController(animated: true)
    }
}

