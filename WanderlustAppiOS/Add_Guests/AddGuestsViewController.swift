//
//  AddGuestsViewController.swift
//  WanderlustAppiOS
//
//  Created by Sai Sriker Reddy Vootukuri on 4/5/24.
//

import UIKit

class AddGuestsViewController: UIViewController {
    
    let addGuestView = AddGuestsView()
    
    override func loadView() {
        view = addGuestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Guests"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
