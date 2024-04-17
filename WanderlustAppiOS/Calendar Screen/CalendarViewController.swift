//
//  PlansViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import UIKit

class CalendarViewController: UIViewController{
    let homeScreen = CalendarView()
    //var selectedDates = [DateComponents]()
    var selectedDates: [Date] = []
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create plan"
        
        // Hide the default back button (arrow)
//        navigationItem.hidesBackButton = true
//        // Create a custom back button which is basically invisible and has no functionlaity.
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.leftBarButtonItem = backButton
        
        // UICalendarView behavior...
        let multiSelect = UICalendarSelectionMultiDate(delegate: self)
        homeScreen.calendarView.selectionBehavior = multiSelect
        homeScreen.calendarView.delegate = self
        
        homeScreen.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
    }
    
    //MARK: Function to insert a date into the selectedDates array in sorted order
    func insertDate(_ date: DateComponents, into array: inout [DateComponents]) {
        // Find the index where the date should be inserted
        let insertionIndex = array.firstIndex { $0.date! > date.date! } ?? array.endIndex
        
        // Insert the date at the calculated index
        array.insert(date, at: insertionIndex)
    }
    
    //MARK: Function to remove a date from the selectedDates array
    func removeDate(_ date: DateComponents, from array: inout [DateComponents]) {
        // Find the index of the date to remove
        if let index = array.firstIndex(where: { $0.date == date.date }) {
            // Remove the date at the found index
            array.remove(at: index)
        }
    }

    //MARK: action to perform when next button is tapped...
    @objc func onNextButtonTapped() {
        let addGuestsController = AddGuestsViewController()
        addGuestsController.selectedDates = selectedDates
        navigationController?.pushViewController(addGuestsController, animated: true)
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionMultiDateDelegate{
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        if let date = dateComponents.date {
            selectedDates.append(date)
        }
    }
        
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        if let date = dateComponents.date, let index = selectedDates.firstIndex(of: date) {
            selectedDates.remove(at: index)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        guard let day = dateComponents.day else {
            return false
        }
        return day.isMultiple(of: 1)
    }

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
}



