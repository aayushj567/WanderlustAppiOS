//
//  EditProfileFirebase.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/18/24.
//

import Foundation
import FirebaseAuth

extension EditProfileViewController{
    
    //MARK: Check if email or password was edited...
    func wasEmailOrPasswordEdited(){
        // Check if name, email, or profile picture was edited
        let name = editProfileScreen.textFieldName.text
        let email = editProfileScreen.textFieldEmail.text
        // check if name or email is left empty
        if name != nil && email != nil {
            if name != Auth.auth().currentUser?.displayName || email != Auth.auth().currentUser?.email {
                print("Name or email was edited")
                editDetailsInFirestore(name, email)
            }
        }
    }
    
    //MARK: Edit the details in Firestore...
    func editDetailsInFirestore(_ newName:String?, _ newEmail:String?) {
        let userID = Auth.auth().currentUser?.uid
        db.collection("users").document(userID!).updateData(
            ["name": newName!, "email": newEmail!]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated in Firestore")
                self.editDetailsInFirebaseAuth()
            }
        }
    }
    
    //MARK: Edit the details in Firebase Authentication...
    func editDetailsInFirebaseAuth(){
        let user = Auth.auth().currentUser
        let originalEmail = user?.email
        let originalName = user?.displayName
        
        // check if email was edited
        
        if originalEmail != editProfileScreen.textFieldEmail.text! {
            user?.updateEmail(to: editProfileScreen.textFieldEmail.text!, completion: { error in
                if let error = error {
                    print("Error updating email in Firebase Authentication: \(error)")
                    //return
                }
            })
        }
        
        // check if name was edited
        if originalName != editProfileScreen.textFieldName.text {
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = editProfileScreen.textFieldName.text
            changeRequest?.commitChanges(completion: {(error) in
                if error == nil{
                    print("User updated successfully in Firebase Authentication")
                }else{
                    print("Error occured: \(String(describing: error))")
                }
            })
        }
    }
    
    
    
//    func editDetailsInFirebaseAuth(){
//        let user = Auth.auth().currentUser
//        let email = newEmail ?? user?.email
//        let password = newPassword
//
//        user?.updateEmail(to: email!, completion: { error in
//            if let error = error {
//                print("Error updating email in Firebase Authentication: \(error)")
//                return
//            }
//
//            if let newPassword = password {
//                user?.updatePassword(to: newPassword, completion: { error in
//                    if let error = error {
//                        print("Error updating password in Firebase Authentication: \(error)")
//                    } else {
//                        print("User updated successfully in Firebase Authentication")
//                    }
//                })
//            } else {
//                print("User updated successfully in Firebase Authentication")
//            }
//        })
//    }
}
