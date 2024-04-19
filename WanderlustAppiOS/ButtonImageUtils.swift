//
//  ImageViewUtils.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/12/24.
//

import Foundation
import UIKit

extension UIButton {
    
    func setRounded() {
       self.layer.cornerRadius = 24
       self.layer.masksToBounds = true
    }
    
    func loadRemoteImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                        //self?.contentMode = .scaleAspectFit // Adjust content mode
                    }
                }
            }
        }
    }
}


