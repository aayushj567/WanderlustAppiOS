//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit

class ViewController: UIViewController {

    let loginScreen = LoginView()
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Login"
        // Do any additional setup after loading the view.
        checkLoginStatus()
        navigationController?.navigationBar.prefersLargeTitles = true
        loginScreen.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        loginScreen.buttonRegister.addTarget(self, action: #selector(onRegistrationTapped), for: .touchUpInside)
        
    }
    
    func checkLoginStatus()
    {
    
        if UserDefaults.standard.string(forKey: "authToken") != nil
        {
            //let mainScreen = NoteViewController()
            //Setting up the contact object of display screen.
            //Instead of sending the variables used a struct named Contact to send the details.
            
          
            //navigationController?.pushViewController(mainScreen, animated: true)
            
            
        }
    }

    
    @objc func onLoginTapped(){
       
//        guard let emailText = loginScreen.textFieldEmail.text, !emailText.isEmpty,
//              let passwordText = loginScreen.textFieldPassword.text, !passwordText.isEmpty
//        else {
//            showAlert(message: "Please fill out all required fields.")
//            return
//        }
//        
//        guard isValidEmail(emailText) else {
//            showAlert(message: "Invalid email. Please enter a valid email address.")
//            return
//        }
        
        //let user = User(id:"", name: "", email: emailText, password: passwordText)
        
        //loginExistingUser(user:user)
        //let mainScreen = NoteViewController()
        //navigationController?.pushViewController(mainScreen, animated: true)
        let mainScreen = CalendarViewController()
        //Setting up the contact object of display screen.
        //Instead of sending the variables used a struct named Contact to send the details.
        
      
        navigationController?.pushViewController(mainScreen, animated: true)
        
    }
    
    @objc func onRegistrationTapped(){
       
        let registrationScreen = RegistrationViewController()
        //Setting up the contact object of display screen.
        //Instead of sending the variables used a struct named Contact to send the details.
        
        navigationController?.pushViewController(registrationScreen, animated: true)
        
        
        
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
    
    
//    func loginExistingUser(user: User) {
//        guard let url = URL(string: "http://apis.sakibnm.space:3000/api/auth/login") else {
//            showAlert(message: "Invalid URL.")
//            return
//        }
//
//        let parameters: [String: Any] = [
//            "email": user.email,
//            "password": user.password
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseDecodable(of: LoginResponse.self) { response in
//                switch response.result {
//                case .success(let loginResponse):
//                    // Use the token from the login response
//                    UserDefaults.standard.set(loginResponse.token, forKey: "authToken")
//                    // Proceed to the main screen
//                    self.sendUserToMainScreen(user: user)
//
//                case .failure(let error):
//                    self.showAlert(message: "Login failed: Invalid email or password!!")
//                }
//            }
//    }

    
    
//    func sendUserToMainScreen(user:User)
//    {
//
//            let mainScreen = NoteViewController()
//            //Setting up the contact object of display screen.
//            //Instead of sending the variables used a struct named Contact to send the details.
//
//            mainScreen.user = user
//            navigationController?.pushViewController(mainScreen, animated: true)
//
//
//        }
    
    
    
}


