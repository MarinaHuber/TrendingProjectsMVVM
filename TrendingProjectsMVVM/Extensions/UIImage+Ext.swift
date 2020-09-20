//
//  UIImage+Ext.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/20/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import UIKit


extension UIImageView {
    
    public func maskCircle(anyImage: UIImage) {
        self.contentMode         = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius  = self.frame.width / 2
        self.layer.borderWidth   = 1.0
        self.layer.borderColor   = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.clipsToBounds       = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image               = anyImage
    }
}
