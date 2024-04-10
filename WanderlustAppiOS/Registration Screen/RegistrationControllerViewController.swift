//
//  ViewController.swift
//  WA6_Basu_7118
//
//  Created by Anwesa Basu on 25/02/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {
    
    let registrationScreen = RegistrationView()
    var delegate:RegistrationViewController!
    
    let db = Firestore.firestore()
    
    override func loadView() {
        view = registrationScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Register"
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        registrationScreen.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        
    }

    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        guard let nameText = registrationScreen.textFieldName.text, !nameText.isEmpty,
              let emailText = registrationScreen.textFieldEmail.text, !emailText.isEmpty,
              let passwordText = registrationScreen.textFieldPassword.text, !passwordText.isEmpty
        else {
            showAlert(message: "Please fill out all required fields.")
            return
        }
        
        guard isValidEmail(emailText) else {
            showAlert(message: "Invalid email. Please enter a valid email address.")
            return
        }
        
        //let user = User(id:"", name: nameText, email: emailText, password: passwordText)
        
        //addNewUser(user:user)
        registerNewAccount()
        sendUserToLoginScreen()
        
        
        //MARK: call add a new contact API endpoint...
        //addANewContact(contact: contact)
        
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
  
    
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: add a new contact call: add endpoint...
//    func addNewUser(user:User){
//        if let url = URL(string: "http://apis.sakibnm.space:3000/api/auth/register"){
//
//            AF.request(url, method:.post, parameters:
//                        [
//                            //MARK: we can unwrap them here since we made sure they are not null above...
//                            "name": user.name,
//                            "email": user.email,
//                            "password": user.password!
//                        ])
//                .responseString(completionHandler: { response in
//                    //MARK: retrieving the status code...
//                    let status = response.response?.statusCode
//
//                    switch response.result{
//                    case .success(let data):
//                        //MARK: there was no network error...
//
//                        //MARK: status code is Optional, so unwrapping it...
//                        if let uwStatusCode = status{
//                            switch uwStatusCode{
//                                case 200...299:
//                                //MARK: the request was valid 200-level...
//
//                                self.showRegistrationSuccessAlert()
//                                    break
//
//                                case 400...499:
//                                //MARK: the request was not valid 400-level...
//                                self.showAlert(message: "Registration failed. Invalid request.Please try again.")
//                                    break
//
//                                default:
//                                //MARK: probably a 500-level error...
//                                self.showAlert(message: "Registration failed: User already exists!!!")
//                                    break
//
//                            }
//                        }
//                        break
//
//                    case .failure(let error):
//                        //MARK: there was a network error...
//                        self.showAlert(message: "Network error. Please try again.")
//                        break
//                    }
//                })
//        }else{
//            //alert that the URL is invalid...
//            showAlert(message: "Invalid URL.")
//        }
//    }
//
    func showRegistrationSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Registration successful. Please log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.sendUserToLoginScreen()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func sendUserToLoginScreen()
    {
        
            
            //Setting up the contact object of display screen.
            //Instead of sending the variables used a struct named Contact to send the details.
            
           
           navigationController?.popToRootViewController(animated: true)
            
            
        }
    
    
}


