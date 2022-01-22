//
//  UILabelFactory.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import UIKit
public class UILabelFactory {

    public class func createUILabel<T: UILabel>(with color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 17), alignment: NSTextAlignment = .left, numberOfLines: Int = 1, lineBreakMode: NSLineBreakMode = .byTruncatingTail, text: String? = nil, alpha: CGFloat = 1.0, adjustFontSize: Bool = true, minimumFontScale:CGFloat = 0.5) -> T {
        let label = T()
        label.font = font
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.text = text
        label.alpha = alpha
        label.minimumScaleFactor = minimumFontScale
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
