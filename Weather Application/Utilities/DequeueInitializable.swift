//
//  DequeueInitializable.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation
import UIKit

protocol DequeueInitializable {
    static var reuseableIdentifier: String { get }
}

extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
}

extension DequeueInitializable where Self: UICollectionViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
}
