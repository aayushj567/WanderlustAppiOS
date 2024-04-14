//
//  RegistrationFirebase.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/9/24.
//

/*
    This file contains the Firebase registration logic for the registration screen.
 */

import Foundation
import FirebaseAuth
import FirebaseStorage

extension RegistrationViewController{
    
    func uploadProfilePhotoToStorage(){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            // Convert the UIImage to Data
            if let jpegData = image.jpegData(compressionQuality: 95){
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
                // Create a child reference
                // imagesRepo now points to "imagesUsers"
                let imagesRepo = storageRef.child("imagesUsers")
                // creating a jpg file with unique id in imageUsers folder...
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                // Upload the image data to Firebase Storage in the image reference
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.registerNewAccount(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            registerNewAccount(photoURL: profilePhotoURL)
        }
    }
    
    
    //MARK: create a Firebase user with email and password in Firebase Auth...
    func registerNewAccount(photoURL: URL?){
        if let name = registrationScreen.textFieldName.text,
           let email = registrationScreen.textFieldEmail.text,
           let password = registrationScreen.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameAndPhotoOfTheUserInFirebaseAuth(name: name, email: email, photoURL: photoURL)
                }else{
                    //MARK: there is a error creating the user...
                    print(error ?? "Error creating user!")
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.saveUserToFirestore(photoURL: photoURL)
                //self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    // MARK: Save the user data to Firestore database...
    func saveUserToFirestore(photoURL: URL?){
        // Gather the data from the text fields...
        let registeredEmail = registrationScreen.textFieldEmail.text!
        let registeredName = registrationScreen.textFieldName.text!
        guard let uid = Auth.auth().currentUser?.uid else {
               print("Error: User not logged in")
               return
        }
        let collectionUser = db.collection("users")
        let user = User(id: uid, name: registeredName, phone: "", imageURL: photoURL, email: registeredEmail)
        let userDocumentRef = collectionUser.document(uid)
        do{
            try userDocumentRef.setData(from: user) { error in
                if let error = error {
                    print("Error adding user document: \(error.localizedDescription)")
                } else {
                    print("Successfully added user")
                    self.sendUserToLoginScreen()
                }
            }
        }catch{
            print("Error adding user document!")
        }

    }

}
