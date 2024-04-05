//
//  ViewController.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 3/22/24.
//

import UIKit

class ViewController: UIViewController {
    
    let homeScreen = HomeView()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }

    

}

