//
//  ViewController.swift
//  WA6_Basu_7118
//
//  Created by Anwesa Basu on 25/02/24.
//
 
import UIKit
import FirebaseAuth
import FirebaseFirestore
 
class FirstViewController: UIViewController {
    
    let firstView = FirstView()
    
    let db = Firestore.firestore()
    
    var pickedImage:UIImage?
    
    let userId = Auth.auth().currentUser?.uid
    
    var userName = ""
    
    override func loadView() {
        view = firstView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.newPlanButton.addTarget(self, action: #selector(onNewButtonTapped), for: .touchUpInside)
        firstView.allPlansButton.addTarget(self, action: #selector(onAllPlansButtonTapped), for: .touchUpInside)
        
        getUser()
        navigationItem.hidesBackButton = true
        firstView.labelWelcomeLabel.text = "Welcome, \(userName)"
        firstView.labelTextLabel.text = "What would you like to do today ?"
    }
    
    @objc func onNewButtonTapped(){
        let mainScreen = CalendarViewController()
        navigationController?.pushViewController(mainScreen, animated: true)
    }
    
    @objc func onAllPlansButtonTapped(){
        let myplans = MyPlansViewController()
        navigationController?.pushViewController(myplans, animated: true)
    }
    
    func getUser(){
        // let db = Firestore.firestore()
        let usersRef = db.collection("users").whereField("id", isEqualTo: userId)
        // print("Enter into the function")
        
        usersRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // Iterate over each plan document
                for userDocument in querySnapshot!.documents {
                    do {
                        // Try to decode the plan document into a Plan struct
                        print("inside else")
                        var user = try userDocument.data(as: User.self)
                        self.userName = user.name!
                    }
                    catch {
                        print("Error decoding plan: \(error)")
                    }
                }
            }
        }
    }
}
 
