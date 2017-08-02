//
//  UIBarButtonItem-Extension.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/2.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, highLightImageName: String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        let image = UIImage(named: imageName)
        
        btn.setImage(image, for: UIControlState.normal)
        
        if highLightImageName != "" {
            btn.setImage(image, for: UIControlState.highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
