//
//  CollectionNormalCell.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/3.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
        
    }
    
    

}
