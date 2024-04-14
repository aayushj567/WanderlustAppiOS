//
//  PlansViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import UIKit
import FirebaseAuth

class CalendarViewController: UIViewController{
    let homeScreen = CalendarView()
    var selectedDates = [DateComponents]()
    // variable to keep an instance of the current signed-in Firebase user
    var currentUserDelegate:FirebaseAuth.User?
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create plan"
        
        // Hide the default back button (arrow)
        navigationItem.hidesBackButton = true

        // Create a custom back button which is basically invisible and has no functionlaity.
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        let multiSelect = UICalendarSelectionMultiDate(delegate: self)
        homeScreen.calendarView.selectionBehavior = multiSelect
        homeScreen.calendarView.delegate = self
        homeScreen.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
        fetchUserFromFirestore()
    }
    
    //MARK: Function to insert a date into the array in sorted order
    func insertDate(_ date: DateComponents, into array: inout [DateComponents]) {
        // Find the index where the date should be inserted
        let insertionIndex = array.firstIndex { $0.date! > date.date! } ?? array.endIndex
        
        // Insert the date at the calculated index
        array.insert(date, at: insertionIndex)
    }
    
    //MARK: Function to remove a date from the array
    func removeDate(_ date: DateComponents, from array: inout [DateComponents]) {
        // Find the index of the date to remove
        if let index = array.firstIndex(where: { $0.date == date.date }) {
            // Remove the date at the found index
            array.remove(at: index)
        }
    }

    //MARK: action to perform when next button is tapped...
    @objc func onNextButtonTapped(){
        let addGuestsCOntroller = AddGuestsViewController()
        addGuestsCOntroller.currentUserDelegate = self.currentUserDelegate
        navigationController?.pushViewController(addGuestsCOntroller, animated: true)
    }
    
    func fetchUserFromFirestore() {
        if let user = currentUserDelegate {
            print("User ID: \(user.uid)")
            print("Name: \(user.displayName ?? "N/A")")
            print("Email: \(user.email ?? "N/A")")
            print("Image URL: \(user.photoURL?.absoluteString ?? "N/A")")
        } else {
            print("No current user")
        }
    }
}

//MARK: extension to handle calendar view selection and deselection of dates...
extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionMultiDateDelegate{
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
//        var selected = selection.selectedDates
//        selected.removeAll { $0 == dateComponents }
//        selection.setSelectedDates(selected, animated: false)
        //print("Selected Date:", dateComponents)
        self.insertDate(dateComponents, into: &self.selectedDates)
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        guard let day = dateComponents.day else {
            return false
        }
        return day.isMultiple(of: 1)
    }

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
            //return dateComponents.day != 14
        return true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        //print("Deselected Date:", dateComponents)
        self.removeDate(dateComponents, from: &self.selectedDates)
    }
    
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}



