//
//  UIViewController+Extension.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 23/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func isProgressHudShown(_ show: Bool) {
        
        if !show {
            dismiss(animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
}
