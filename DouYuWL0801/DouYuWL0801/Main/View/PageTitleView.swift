//
//  PageTitleView.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/2.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

protocol pageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}


private let kScrollLineH : CGFloat = 2

private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    // MARK:- 属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : pageTitleViewDelegate?
    

    // MARK:- 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
    self.titles = titles
    
    super.init(frame: frame)
    
    setupUI()
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        addTitleLabels()
        addBottomLineAndScrollLine()
    }
    
    fileprivate func addTitleLabels() {
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - kScrollLineH
        
        for (index, item) in titles.enumerated() {
            let label = UILabel()
            label.frame = CGRect(x: CGFloat(index) * labelW, y: 0, width: labelW, height: labelH)
            
            label.text = item
            label.tag = index
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
            
        }
        
    }
    fileprivate func addBottomLineAndScrollLine() {
        let bottomViewH : CGFloat = 0.5
        
        let bottomView = UIView()
        scrollView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.lightGray
        bottomView.frame = CGRect(x: 0, y: frame.height - bottomViewH, width: frame.width, height: bottomViewH)
        
        // 取出第一个label
        guard let firstLabel = titleLabels.first else { return }
        
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        // 1.取出当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        // 2.如果当前点击的是上一个label的话  就直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.3, animations: { 
            self.scrollLine.frame.origin.x = scrollLineX
        }, completion: nil)
        
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}
// MARK:- 对外暴露方法 让pageContentView 的代理方法执行该暴露的方法，也就是说滚动的时候titleView要做什么
extension PageTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
