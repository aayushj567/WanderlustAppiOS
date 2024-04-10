//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    // an authentication state change listener used to track whether any user is signed in
    var handleAuth: AuthStateDidChangeListenerHandle?
    // variable to keep an instance of the current signed-in Firebase user
    var currentUser:FirebaseAuth.User?

    let loginScreen = LoginView()
    override func loadView() {
        view = loginScreen
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        loginScreen.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onRegistrationTapped), for: .touchUpInside)
        
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                
            } else {
                //MARK: the user is signed in...
                let mainScreen = CalendarViewController()
                self.navigationController?.pushViewController(mainScreen, animated: true)
            }
        }
        
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }
    
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
            showAlert(title: "Error", message: "Please fill out all required fields.")
            return
        }
        
        guard isValidEmail(emailText) else {
            showAlert(title: "Error", message: "Invalid email. Please enter a valid email address.")
            return
        }
        signIntoFirebase(email: emailText, password: passwordText)
    }
    
    
    // Comment added
    @objc func onRegistrationTapped(){
       
        let registrationScreen = RegistrationViewController()
        navigationController?.pushViewController(registrationScreen, animated: true)
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}



