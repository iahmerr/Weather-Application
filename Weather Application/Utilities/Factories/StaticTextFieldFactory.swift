//
//  StaticTextFieldFactory.swift
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import UIKit

public class StaticTextFieldFactory {
    
    public class func createField(title: String = String(),
                                  text: String = String(),
                                  isEditable: Bool = false) -> UITextField {
        let field = UITextField()
        field.placeholder = title
        field.text = text
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}
