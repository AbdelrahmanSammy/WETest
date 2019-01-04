//
//  Extension.swift
//  Qedrah
//
//  Created by Kemo on 11/20/18.
//  Copyright © 2018 Qedrah. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {

    func setleftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 15, height: 15))
        iconView.image = image
        iconView.contentMode = .center
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView  = iconContainerView
        leftViewMode = .always
    }
    
    func setrightIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 15, height: 15))
        iconView.image = image
        iconView.contentMode = .center

        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView  = iconContainerView
        rightViewMode = .always
    }
}
