//
//  Double+Extension.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 22/01/2022.
//

import Foundation
// MARK: - Double Extension
extension Double {
    func roundedString(to digits: Int) -> String {
        String(format: "%.\(digits)f", self)
    }
}
