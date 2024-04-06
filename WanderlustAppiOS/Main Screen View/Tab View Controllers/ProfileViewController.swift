//
//  PlansViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import UIKit

class ProfileViewController: UIViewController {
    let redView = ProfileView()
    
    override func loadView() {
        view = redView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //title = "Profile"
    }
}
