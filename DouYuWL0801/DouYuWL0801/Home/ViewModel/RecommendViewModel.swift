//
//  RecommendViewModel.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func requestData(_ finishedCallback : @escaping () ->
        ()) {
        let parameters = ["limit" : "4", "offset" : "0", "time": Date.getCurrentTime()]
        
        let dgroup = DispatchGroup()
        
        dgroup.enter()
        NetWorkTool.requestDate(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime()]) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                self.bigDataGroup.anchors.append(AnchorModel(dict: dict))
            }
            dgroup.leave()
        }
        
        dgroup.enter()
        NetWorkTool.requestDate(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else { return }
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dgroup.leave()
        }
        
        dgroup.notify(queue : DispatchQueue.main) {
            self.anchorgroups.insert(self.prettyGroup, at: 0)
            self.anchorgroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
    }
}
