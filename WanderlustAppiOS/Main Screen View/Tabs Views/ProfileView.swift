//
//  HomeView.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/3/24.
//

import UIKit

class ProfileView: UIView {
    var buttonSend: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Send Hello", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
        
        NSLayoutConstraint.activate([
            buttonSend.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            buttonSend.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
