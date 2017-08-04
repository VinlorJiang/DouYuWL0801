//
//  GameViewModel.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    lazy var gameModel : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetWorkTool.requestDate(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            guard let resultDic = result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.gameModel.append(GameModel(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
