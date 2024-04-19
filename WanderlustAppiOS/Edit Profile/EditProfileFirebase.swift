//
//  EditProfileFirebase.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/18/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

extension EditProfileViewController{
    
    @objc func reauthenticateUser() {
        // Assume user is already signed in
        guard let user = Auth.auth().currentUser else {
            // User is not signed in
            return
        }

        // Ask the user to enter their current password (e.g., through an alert)
        let reauthAlert = UIAlertController(title: "Reauthentication", message: "Please enter your current password", preferredStyle: .alert)
        reauthAlert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }

        reauthAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        reauthAlert.addAction(UIAlertAction(title: "Reauthenticate", style: .default, handler: { _ in
            guard let password = reauthAlert.textFields?.first?.text else { return }
            
            // Create a credential with the user's current email and password
            let credential = EmailAuthProvider.credential(withEmail: user.email!, password: password)
            
            // Reauthenticate the user with the credential
            user.reauthenticate(with: credential) { authResult, error in
                if let error = error {
                    // Reauthentication failed
                    print("Reauthentication failed:", error.localizedDescription)
                } else {
                    // Reauthentication successful
                    print("Reauthentication successful")
                    // Proceed with the desired action (e.g., updating email, password, etc.)
                }
            }
        }))

        // Present the alert
        self.present(reauthAlert, animated: true, completion: nil)
        return
    }
    
    //MARK: Check if email or password was edited...
    func wasProfileEdited(){
        // Check if name, email, or profile picture was edited
        let name = editProfileScreen.textFieldName.text
        let email = editProfileScreen.textFieldEmail.text
        // check if name or email is left empty
        if name != nil && email != nil {
            // check if email or name is the same...
            if name != Auth.auth().currentUser?.displayName || email != Auth.auth().currentUser?.email {
                print("Name or email was edited by user")
                self.reauthenticateUser()
                self.editDetailsInFirestore(name, email)
            } else {
                if self.imageWasChanged {
                    self.reauthenticateUser()
                    self.uploadProfilePhotoToStorage()
                }
            }
        }
    }
    
    //MARK: Delete photo from Firebase Storage...
    func deleteImageFirebaseStorage(){
        // Check if a user is currently signed in
        if let currentUser = Auth.auth().currentUser {
            // if user is signed in load thir image
            if let imageURL = currentUser.photoURL {
                // Get a reference to the Firebase storage service
                let storage = Storage.storage()
                // Create a storage reference from the URL
                let storageRef = storage.reference(forURL: imageURL.absoluteString)
                // Delete the file
                storageRef.delete { error in
                    if let error = error {
                        print("Error deleting image: \(error.localizedDescription)")
                    } else {
                        print("Image deleted successfully!")
                        self.deleteImageURLFirestore()
                    }
                }
                
            }
        }
    }
    
    //MARK: Delete image url from Firestore...
    func deleteImageURLFirestore() {
        // fetching user id
        let userID = Auth.auth().currentUser?.uid
        // reference to current user document
        let userRef = db.collection("users").document(userID!)
        // try deleting the field containing the image url
        userRef.updateData(["image": FieldValue.delete()]) { error in
            if let error = error {
                print("Error deleting imageURL field from Firestore: \(error.localizedDescription)")
            } else {
                print("Image URL deleted successfully from Firestore!")
                self.deleteImageFromAuth()
            }
        }
    }
    
    //MARK: Delete image url from Firebase Auth...
    func deleteImageFromAuth() {
        let user = Auth.auth().currentUser
        let changeRequest = user?.createProfileChangeRequest()
        // Set photoURL to nil to delete it
        changeRequest?.photoURL = nil
        // Commit changes
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                print("Profile updated successfully.")
                print("User's profile is: \(String(describing: user?.photoURL))")
            }
        }
    }
    
    //MARK: Upload new image, if any, to Firebase Storage...
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
                _ = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{ // if no error in uploading
                        imageRef.downloadURL(completion: {(url, error) in // fetch download link of image
                            if error == nil{
                                // save the download link in local variable
                                profilePhotoURL = url
                                // call the edit image in firestore function...
                                self.editImageInFirestore(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            self.deleteImageFirebaseStorage()
        }
    }
    
    //MARK: uploading the image url in Firestore under user's documents...
    func editImageInFirestore(photoURL: URL?){
        let userID = Auth.auth().currentUser?.uid
        db.collection("users").document(userID!).updateData(
            ["image": photoURL?.absoluteString]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated in Firestore")
                self.editImageInFirebaseAuth(photoURL: photoURL)
            }
        }
    }
    
    //MARK: Editing the profile photo url in Auth...
    func editImageInFirebaseAuth(photoURL: URL?){
        let user = Auth.auth().currentUser
        let changeRequest = user?.createProfileChangeRequest()
        // Set photoURL to nil to delete it
        changeRequest?.photoURL = photoURL
        // Commit changes
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                print("Profile updated successfully.")
                print("User's profile photo after adding is: \(String(describing: user?.photoURL))")
            }
        }
    }
    
    //MARK: Edit the name and email details in Firestore...
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
    
    //MARK: Edit name and email details in Firebase Authentication...
    func editDetailsInFirebaseAuth(){
        let user = Auth.auth().currentUser
        let originalEmail = user?.email
        let originalName = user?.displayName
        
        // check if email was edited
        if originalEmail != editProfileScreen.textFieldEmail.text!{
            // Proceed with updating email
            user?.updateEmail(to: self.editProfileScreen.textFieldEmail.text!, completion: { error in
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
}
