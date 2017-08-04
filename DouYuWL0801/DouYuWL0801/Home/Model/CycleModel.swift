//
//  CycleModel.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title : String = ""
    
    var pic_url : String = ""
    
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor : AnchorModel?
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
