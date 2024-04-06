//
//  PlansViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import UIKit

class CalendarViewController: UIViewController{
    let homeScreen = CalendarView()
    var selectedDates = [DateComponents]()
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create plan"
        
        let multiSelect = UICalendarSelectionMultiDate(delegate: self)
        homeScreen.calendarView.selectionBehavior = multiSelect
        
        homeScreen.calendarView.delegate = self
        
        homeScreen.buttonNext.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
    }
    
    // Function to insert a date into the array in sorted order
    func insertDate(_ date: DateComponents, into array: inout [DateComponents]) {
        // Find the index where the date should be inserted
        let insertionIndex = array.firstIndex { $0.date! > date.date! } ?? array.endIndex
        
        // Insert the date at the calculated index
        array.insert(date, at: insertionIndex)
    }
    
    // Function to remove a date from the array
    func removeDate(_ date: DateComponents, from array: inout [DateComponents]) {
        // Find the index of the date to remove
        if let index = array.firstIndex(where: { $0.date == date.date }) {
            // Remove the date at the found index
            array.remove(at: index)
        }
    }

    
    @objc func onNextButtonTapped(){
        print("Printing selected dates....")
        print("")
        for date in self.selectedDates{
            print(date)
        }
    }
}

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



