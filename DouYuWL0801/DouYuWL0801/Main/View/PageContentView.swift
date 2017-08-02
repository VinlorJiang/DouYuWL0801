//
//  PageContentView.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/2.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit


protocol pageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK:- 属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startoffsetX : CGFloat = 0
    weak var delegate : pageContentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectonView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectonView.showsHorizontalScrollIndicator = false
        collectonView.isPagingEnabled = true
        collectonView.bounces = false
        collectonView.scrollsToTop = false
        collectonView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectonView.dataSource = self
        collectonView.delegate = self
        
        return collectonView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        for vc in childVcs {
            parentViewController?.addChildViewController(vc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startoffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startoffsetX {
            
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startoffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

extension PageContentView {
    func setCurrntIndex(_ currentIndex : Int) {
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
