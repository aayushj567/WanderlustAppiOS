//
//  passwordTextFieldToggle.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/18/24.
//

import Foundation
import UIKit

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setTitle("Show", for: .normal)
        }else{
            button.setTitle("Hide", for: .normal)
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .system)
        setPasswordToggleImage(button)
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        var config = UIButton.Configuration.filled()
        // Adjust the padding for the image
        config.imagePadding = 16 // Adjust the left padding to -16
        // Apply the configuration to your UIButton
        button.configuration = config
        
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(20), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
