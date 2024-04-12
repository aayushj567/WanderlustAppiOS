//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit
import GooglePlaces
import GoogleMaps


class SearchDestinationController: UIViewController {
    
    var searchDestinationView: SearchDestinationView!
    var destinations: [Destination] = []
    var activityIndicator: UIActivityIndicatorView?
    let placesClient = GMSPlacesClient.shared()
    
    override func loadView() {
        searchDestinationView = SearchDestinationView()
        view = searchDestinationView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchDestinationView.contentWrapper.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
            searchDestinationView.searchBar.delegate = self
            searchDestinationView.tableView.delegate = self
            searchDestinationView.tableView.dataSource = self
            searchDestinationView.tableView.rowHeight = UITableView.automaticDimension
            searchDestinationView.tableView.estimatedRowHeight = 100
        searchDestinationView.nextButton.addTarget(self, action: #selector(onNextButtonTapped), for: .touchUpInside)
        
        searchDestinationView.onIconTapped = { [unowned self] index in
            // Handle the icon tap, switch views accordingly
//            if(index == 0){
//                let homeView = CalendarViewController()
//                navigationController?.pushViewController(homeView, animated: true)
//            }
//            if(index == 1){
//                let myplansVC = MyPlansViewController()
//                navigationController?.pushViewController(myplansVC, animated: true)
//            }
//            if(index == 2)
//            {
//                let chatView = ChatViewController()
//                navigationController?.pushViewController(chatView, animated: true)
//            }
//            print("Icon at index \(index) was tapped.")
//            if(index == 3)
//            {
//                let profileView = ShowProfileViewController()
//                navigationController?.pushViewController(profileView, animated: true)
//            }
            
            // Insert logic to switch to the corresponding view
        }
        
        searchDestinationView.tableView.reloadData()
    }
    
    
    @objc func onNextButtonTapped(){
//        let myPlanVC = MyPlansViewController()
//        navigationController?.pushViewController(myPlanVC, animated: true)
    }
    
    func fetchDetailsForPlace(placeID: String, completion: @escaping (Destination) -> Void) {
        let fields: GMSPlaceField = [.name, .rating, .priceLevel, .photos]
        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil) { (place, error) in
            guard let place = place, error == nil else {
                print("Error fetching details for placeID \(placeID): \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            var destination = Destination(
                name: place.name ?? "Unknown",
                rating: String(place.rating),
                admissionPrice: place.priceLevel != nil ? "$\(place.priceLevel)" : nil,
                isAddedToPlan: false
            )
            
            // Assuming you want to load the first photo if it exists
            if let photoMetadata = place.photos?.first {
                self.placesClient.loadPlacePhoto(photoMetadata, constrainedTo: CGSize(width: 300, height: 300), scale: UIScreen.main.scale) { (photo, error) in
                    guard let photo = photo else {
                        print("Error loading photo: \(error?.localizedDescription ?? "No error")")
                        completion(destination) // Complete with what we have even if the photo couldn't be loaded
                        return
                    }
                    
                    destination.image = photo
                    completion(destination)
                }
            } else {
                completion(destination) // Complete if there are no photos
            }
        }
    }

    
    
    
    
    func searchPlaces(cityName: String, apiKey: String, completion: @escaping ([String]) -> Void) {
        let baseTextSearchURL = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        let query = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseTextSearchURL)?query=points+of+interest+in+\(query)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = jsonResult["results"] as? [[String: Any]] {
                    let placeIds = results.compactMap { $0["place_id"] as? String }
                    DispatchQueue.main.async {
                        completion(placeIds)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            } catch {
                print("Failed to parse JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }

    
    func executeSearch(query: String) {
            // Here, instead of populating with static data, you would perform your API call.
            // For now, we'll just populate with static data when search is executed.
        activityIndicator?.startAnimating()
           // Here, instead of populating with static data, you would perform your API call.
           // For now, we'll just simulate an API call with a delay.
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulating network request delay
               self.destinations = [
                   Destination(name: "Eiffel Tower", rating: "4.8", admissionPrice: "15.99", isAddedToPlan: false),
                   Destination(name: "Colosseum", rating: "4.7", admissionPrice: "12.00", isAddedToPlan: true),
                   Destination(name: "Statue of Liberty", rating: "4.9", admissionPrice: "18.50", isAddedToPlan: false)
               ]
               self.searchDestinationView.tableView.reloadData()
               self.activityIndicator?.stopAnimating()
           }
            
            
        }
    
}
extension SearchDestinationController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        destinations.removeAll()
        searchDestinationView.tableView.reloadData()
        // Show the activity indicator and start fetching data
        searchDestinationView.activityIndicator.startAnimating()
        
        // Simulate fetching data with a delay
        searchPlaces(cityName: searchText, apiKey: "AIzaSyDYP9pwECmbBwJzOBwzepkQRNpanvnsb3U") { placeIds in
            
                  self.searchDestinationView.activityIndicator.stopAnimating()
                  
                  print("Fetched place IDs: \(placeIds)")
            for placeId in placeIds {
                self.fetchDetailsForPlace(placeID: placeId) { destination in
                    self.destinations.append(destination)
                    DispatchQueue.main.async {
                        self.searchDestinationView.tableView.reloadData()
                    }
                }
            }
                  
                  // Use placeIds to fetch more details for each place
                  // Update your destinations array and reload the table view
              }
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
        //cell.destinationPriceLabel.text = "$\(destination.admissionPrice)"
        cell.destinationRatingLabel.text = "★ \(destination.rating)"
        cell.destinationImageView.image = destination.image ?? UIImage(systemName: "photo") // Provide a default image
                
                // ... Other parts of your cellForRowAt ...
                
        
        

          
        
        
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

