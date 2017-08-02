//
//  HomeViewController.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/1.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit


private let kRightBarItemW : CGFloat = 40
private let kRightBarItemH : CGFloat = 40

private let kPageTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {
        let frame = CGRect(x: 0, y: kStatusH + kNavH, width: kScreenW, height: kPageTitleViewH)
        let pageTitleView = PageTitleView(frame: frame, titles: ["推荐","游戏","娱乐","趣玩"])
        
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {
        let y = kNavH + kStatusH + kPageTitleViewH
        let frame = CGRect(x: 0, y: y, width: kScreenW, height: kScreenH - y - kTabBarH)
        
        var viewController = [UIViewController]()
        for i in 0..<4 {
            
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            viewController.append(vc)
        }
        
        let pageContentView = PageContentView(frame: frame, childVcs: viewController, parentViewController: self)
      
        return pageContentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
    }

   
}

extension HomeViewController {
    // MARK:- 设置UI

    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
       
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        
       
    }
    
    
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: kRightBarItemW, height: kRightBarItemH)
        
        let historyBtn = UIBarButtonItem.init(imageName: "image_my_history", highLightImageName: "Image_my_history_click", size: size)
        let searchBtn = UIBarButtonItem.init(imageName: "btn_search", highLightImageName: "btn_search_clicked", size: size)
        let qrcodeBtn = UIBarButtonItem.init(imageName: "Image_scan", highLightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyBtn,searchBtn,qrcodeBtn]
        
}
    
    
}

extension HomeViewController : pageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrntIndex(index)
    }
}

extension HomeViewController : pageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
