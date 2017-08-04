//
//  NetWorkTool.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/4.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get, post
}

class NetWorkTool {
    class func requestDate(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any)->()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error ?? "NetWorkTool error")
                return
            }
            finishedCallback(result)
        }
        
        }
}

