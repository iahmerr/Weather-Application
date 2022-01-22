//
//  UIImageViewFactory.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import UIKit
public class UIImageViewFactory {

    public class func createImageView(mode: UIImageView.ContentMode = .scaleAspectFill, image: UIImage? = nil, tintColor: UIColor? = .clear) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = mode
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }
}
