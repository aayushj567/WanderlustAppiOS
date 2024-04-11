//
//  RegistrationFirebase.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/9/24.
//

import Foundation
import FirebaseAuth

extension RegistrationViewController{
    
    func registerNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let name = registrationScreen.textFieldName.text,
           let email = registrationScreen.textFieldEmail.text,
           let password = registrationScreen.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                }else{
                    //MARK: there is a error creating the user...
                    print(error ?? "Error creating user!")
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.saveUserToFirestore()
                //self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    // MARK: Save the user data to Firestore database...
    func saveUserToFirestore(){
        // Gather the data from the text fields...
        let registeredEmail = registrationScreen.textFieldEmail.text!
        let registeredName = registrationScreen.textFieldName.text!
        let collectionUser = db.collection("users")
        let user = User(name: registeredName, phone: "", image: nil, email: registeredEmail)
        do{
            try collectionUser.addDocument(from: user, completion: {(error) in
                if error == nil{
                    //MARK: hide progress indicator...
                    print("successfully added user")
                }
            })
        }catch{
            print("Error adding user document!")
        }

    }

}
