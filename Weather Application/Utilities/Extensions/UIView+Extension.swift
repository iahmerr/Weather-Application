//
//  UIView+Extension.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 22/01/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func applyShadow() {
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
