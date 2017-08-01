//
//  MainViewController.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/1.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc(storyboardName: "Home")
        addChildVc(storyboardName: "Live")
        addChildVc(storyboardName: "Follow")
        addChildVc(storyboardName: "Discover")
        addChildVc(storyboardName: "Profile")
    
    }

    fileprivate func addChildVc(storyboardName : String) {
        
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(vc)
        
    }

}
