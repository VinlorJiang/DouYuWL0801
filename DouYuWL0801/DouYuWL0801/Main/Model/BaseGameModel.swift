//
//  BaseGameModel.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 控件属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
