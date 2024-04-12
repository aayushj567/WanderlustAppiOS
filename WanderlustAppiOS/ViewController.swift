//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit
import FirebaseAuth

//comment added
class ViewController: UIViewController {
    
    // an authentication state change listener used to track whether any user is signed in
    var handleAuth: AuthStateDidChangeListenerHandle?
    // variable to keep an instance of the current signed-in Firebase user
    var currentUser:FirebaseAuth.User?
    // flag to check if the user has completed the registration process
    var hasCompletedRegistration = false

    let loginScreen = LoginView()
    override func loadView() {
        view = loginScreen
    }
    
    //MARK: add the Firebase auth listener when the view appears...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth = Auth.auth().addStateDidChangeListener{ [weak self] auth, user in
            guard let self = self else { return }
            if user != nil && !self.hasCompletedRegistration { // already a user
                let mainScreen = CalendarViewController();               self.navigationController?.pushViewController(mainScreen, animated: true)
            } else if  user != nil && self.hasCompletedRegistration { // new user just completed registration
                    self.hasCompletedRegistration = false
                    return
            }
        }
    }
    
    //MARK: view did load...
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loginScreen.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onRegistrationTapped), for: .touchUpInside)
    }
    
    //MARK: remove the Firebase auth listener when the view disappears...
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    //MARK: sign-in logic for Firebase...
    func signIntoFirebase(email: String, password: String){
        //authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //user authenticated...
                let mainScreen = CalendarViewController()
                self.navigationController?.pushViewController(mainScreen, animated: true)
            }else{
                //alert that no user found or password wrong...
                self.showAlert(title: "Error", message: "No user found with the provided credentials.")
            }
        })
    }
    
    // MARK: action when the login button is tapped...
    @objc func onLoginTapped(){
        guard let emailText = loginScreen.textFieldEmail.text, !emailText.isEmpty,
              let passwordText = loginScreen.textFieldPassword.text, !passwordText.isEmpty
        else {
            //alert that all fields are required and cannot be empty...
            showAlert(title: "Error", message: "Please fill out all required fields.")
            return
        }
        
        guard isValidEmail(emailText) else {
            //alert that the email is invalid...
            showAlert(title: "Error", message: "Invalid email. Please enter a valid email address.")
            return
        }
        signIntoFirebase(email: emailText, password: passwordText)
    }
    
    //MARK: action when the registration button is tapped...
    @objc func onRegistrationTapped(){
        let registrationScreen = RegistrationViewController()
        navigationController?.pushViewController(registrationScreen, animated: true)
    }

    //MARK: function to check if the email is valid...
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: function to show an alert...
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



