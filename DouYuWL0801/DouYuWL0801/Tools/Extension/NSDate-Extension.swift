//
//  NSDate-Extension.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
