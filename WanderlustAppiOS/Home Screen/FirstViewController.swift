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
    
    var userName = Auth.auth().currentUser?.displayName
    
    override func loadView() {
        view = firstView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.backgroundImage.alpha = 0.3 // Adjust the alpha value
        firstView.newPlanButton.addTarget(self, action: #selector(onNewButtonTapped), for: .touchUpInside)
        firstView.allPlansButton.addTarget(self, action: #selector(onAllPlansButtonTapped), for: .touchUpInside)
        firstView.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        //getUser()
        navigationItem.hidesBackButton = true
        firstView.labelWelcomeLabel.text = "Welcome, \(userName!) !"
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
    
    @objc func logout() {
        
        let logoutAlert = UIAlertController(title: "Log out?", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
 
