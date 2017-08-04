//
//  CollectionBaseCell.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/3.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string : anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
    
}
