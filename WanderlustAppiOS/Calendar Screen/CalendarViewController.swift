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
    var planToEdit: Plan? {
            didSet {
                if isViewLoaded {
                    updateUIForEditing()
                }
            }
        }

    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Plan"
        
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
        
        
        homeScreen.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
            if(index == 0){
                let homeView = FirstViewController()
                navigationController?.pushViewController(homeView, animated: true)
            }
            if(index == 1){
                let myplansVC = MyPlansViewController()
                navigationController?.pushViewController(myplansVC, animated: true)
            }
            if(index == 2)
            {
                let chatView = ChatPlanViewController()
                navigationController?.pushViewController(chatView, animated: true)
            }
            print("Icon at index \(index) was tapped.")
            if(index == 3)
            {
                let profileView = ShowProfileViewController()
                navigationController?.pushViewController(profileView, animated: true)
            }
        }
        updateUIForEditing()
    }
    
    private func updateUIForEditing() {
            guard let plan = planToEdit else { return }
            
            homeScreen.planTextField.text = plan.name
            
//            if let dateFrom = plan.dateFrom, let dateTo = plan.dateTo {
//                // Calculate all dates between dateFrom and dateTo
//                var dates: [Date] = []
//                var currentDate = dateFrom
//                while currentDate <= dateTo {
//                    dates.append(currentDate)
//                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
//                }
//                
//                // Here you might need to adjust the selection behavior of your UICalendarView to reflect the selected dates.
//                // Since UICalendarView is not a standard UIKit component and without documentation, I can't provide exact code.
//                // You'll have to find out how to mark dates as selected in your calendar component.
//                
//                selectedDates = dates
//            }
        }
    
    func updatePlanDates() {
        // Assuming your Plan object has `dateFrom` and `dateTo`
        planToEdit?.dateFrom = selectedDates.min()
        planToEdit?.dateTo = selectedDates.max()
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

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: action to perform when next button is tapped...
    @objc func onNextButtonTapped() {
        let addGuestsController = AddGuestsViewController()
        if homeScreen.planTextField.text?.isEmpty ?? true{
            showAlert(title: "Alert", message: "Plan name is empty")
        }
        else if selectedDates.count == 0{
            showAlert(title: "Alert", message: "Please select days")
        }
        else 
        {
            if var planToEdit = planToEdit {
                planToEdit.name = homeScreen.planTextField.text
                addGuestsController.planToEdit = planToEdit
            }
           print( selectedDates.first!)
            print(selectedDates.last!)
            addGuestsController.selectedDates = selectedDates
            addGuestsController.planName = homeScreen.planTextField.text
            navigationController?.pushViewController(addGuestsController, animated: true)
        }
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionMultiDateDelegate{
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        if let date = dateComponents.date {
            selectedDates.append(date)
            updatePlanDates()
            //updateCalendarUI()
           
        }
    }
        
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        if let date = dateComponents.date, let index = selectedDates.firstIndex(of: date) {
            selectedDates.remove(at: index)
            updatePlanDates()
            //updateCalendarUI()
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




