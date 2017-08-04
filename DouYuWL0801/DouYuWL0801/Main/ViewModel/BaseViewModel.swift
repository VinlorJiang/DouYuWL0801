//
//  BaseViewModel.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorgroups : [AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel {
    func loadAnchorDatas(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping ()->()) {
        NetWorkTool.requestDate(.get, URLString: URLString, parameters: parameters) { (result) in
            
            guard let resultDic = result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {
            return
            }
            
            if isGroupData {
                for dict in dataArray {
                    self.anchorgroups.append(AnchorGroup(dict: dict))
                }
            } else {
                let group = AnchorGroup()
                
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorgroups.append(group)
            }
            finishedCallback()
        }
    }
}
