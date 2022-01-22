//
//  UIButtonFactory.swift
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import UIKit

public class UIButtonFactory {
    
    public class func createButton(title: String = String(), backgroundColor: UIColor = UIColor.clear, textColor: UIColor = .black) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
