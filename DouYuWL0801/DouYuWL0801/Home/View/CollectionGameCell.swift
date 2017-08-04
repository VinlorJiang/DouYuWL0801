//
//  CollectionGameCell.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var gameModel : GameModel? {
        didSet {
            titleLabel.text = gameModel?.tag_name
            if let iconUrl = URL(string : gameModel?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconUrl)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    

}
