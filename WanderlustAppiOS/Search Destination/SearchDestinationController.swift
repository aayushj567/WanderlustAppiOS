//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit

class SearchDestinationController: UIViewController {
    
    var searchDestinationView: SearchDestinationView!
    var destinations = [
            Destination(name: "Eiffel Tower", rating: "4.8", admissionPrice: "15.99", isAddedToPlan: false),
            Destination(name: "Colosseum", rating: "4.7", admissionPrice: "12.00", isAddedToPlan: true),
            Destination(name: "Statue of Liberty", rating: "4.9", admissionPrice: "18.50", isAddedToPlan: false)
            // Add more static data as needed
        ]
    
    override func loadView() {
        searchDestinationView = SearchDestinationView()
        view = searchDestinationView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchDestinationView.contentWrapper.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
            searchDestinationView.tableView.delegate = self
            searchDestinationView.tableView.dataSource = self
            searchDestinationView.tableView.rowHeight = UITableView.automaticDimension
            searchDestinationView.tableView.estimatedRowHeight = 100
        
        
        searchDestinationView.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
            print("Icon at index \(index) was tapped.")
            
            
            // Insert logic to switch to the corresponding view
        }
        searchDestinationView.tableView.reloadData()
    }
}
extension SearchDestinationController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinations", for: indexPath) as! DestinationTableViewCell
        
        let destination = destinations[indexPath.row]
        cell.labelName.text = destinations[indexPath.row].name
        cell.destinationPriceLabel.text = "$\(destination.admissionPrice)"
        cell.destinationRatingLabel.text = "★ \(destination.rating)"
        cell.destinationImageView.image = UIImage(systemName: "photo")
        
        

          
        
        
        cell.addToPlanTapped = { isSelected in
                self.destinations[indexPath.row].isAddedToPlan = isSelected
            print(isSelected)
                // If you want to perform some action after updating
            }
       
        //cell.addToPlanCheckbox.isSelected = destination.isAddedToPlan
        tableView.reloadRows(at: [indexPath], with: .none)
        
//        let buttonOptions = UIButton(type: .system)
//           buttonOptions.sizeToFit()
//           buttonOptions.showsMenuAsPrimaryAction = true
//           //MARK: setting an icon from sf symbols...
//           buttonOptions.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
//
//           //MARK: setting up menu for button options click...
//           buttonOptions.menu = UIMenu(title: "Add to Plan",
//                                       children: [
//                                           UIAction(title: "Add to Plan",handler: {(_) in
//                                               self.addToPlan(destination: self.destinations[indexPath.row])
//                                           })
//                                       ])
//           //MARK: setting the button as an accessory of the cell...
//           cell.accessoryView = buttonOptions

        
        //MARK: setting up menu for button options click...
        
        
      
        return cell
    }
    @objc func incrementAction() {
    }
    
    //extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // Return the number of destinations
    //        print(destinations.count)
    //        return destinations.count
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        // Dequeue and configure the cell with destination data
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "destinations", for: indexPath) as! DestinationTableViewCell
    //
    //        // Configure the cell with the destination data
    //        print("Will display cell for row at \(indexPath.row)")
    //        let destination = destinations[indexPath.row]
    //        //print(destination)
    //        //print(cell.destinationNameLabel!)
    //        //cell.configure(with: destination)
    //        cell.labelName.text = destination.name
    //
    //
    //
    //        // If you want to add a button with options to each cell
    //        let optionsButton = UIButton(type: .system)
    //        optionsButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
    //        optionsButton.showsMenuAsPrimaryAction = true
    //        optionsButton.menu = UIMenu(title: "", children: [
    //            UIAction(title: "Add to Plan", handler: { [weak self] _ in
    //                self?.addToPlan(destination: destination)
    //            }),
    //            // Add more actions as needed
    //        ])
    //        cell.accessoryView = optionsButton
    //
    //        return cell
    //    }
    //
    //    // Additional methods like didSelectRowAt, heightForRowAt, etc.
    //
    //    // Example function to handle adding to plan
    //    private func addToPlan(destination: Destination) {
    //        // Handle the action of adding the destination to the user's plan
    //        // This is where you'd include the API logic to update the plan
    //    }
    //
    //    // ... rest of your DestinationsViewController ...
    //}
    //
    private func addToPlan(destination: Destination) {
        // Handle the action of adding the destination to the user's plan
        // This is where you'd include the API logic to update the plan
    }

}

