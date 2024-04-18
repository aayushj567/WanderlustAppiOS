//
//  EditProfileFirebase.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/18/24.
//

import Foundation
import FirebaseAuth

extension EditProfileViewController{
    
    func wasEmailOrPasswordEdited(){
        
    }
    
    func editDetailsInFirebaseAuth(newEmail: String?, newPassword: String?){
        let user = Auth.auth().currentUser
        let email = newEmail ?? user?.email
        let password = newPassword
        
        user?.updateEmail(to: email!, completion: { error in
            if let error = error {
                print("Error updating email in Firebase Authentication: \(error)")
                return
            }
            
            if let newPassword = password {
                user?.updatePassword(to: newPassword, completion: { error in
                    if let error = error {
                        print("Error updating password in Firebase Authentication: \(error)")
                    } else {
                        print("User updated successfully in Firebase Authentication")
                    }
                })
            } else {
                print("User updated successfully in Firebase Authentication")
            }
        })
    }
}
