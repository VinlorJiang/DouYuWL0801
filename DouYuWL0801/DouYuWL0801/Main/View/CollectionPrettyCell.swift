//
//  CollectionPrettyCell.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/3.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    
    @IBOutlet weak var cityBtn: UIButton!

    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
    
}
