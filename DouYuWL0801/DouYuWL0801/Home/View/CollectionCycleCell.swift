//
//  CollectionCycleCell.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    

}
