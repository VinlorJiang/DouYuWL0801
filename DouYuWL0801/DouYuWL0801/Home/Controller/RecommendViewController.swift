//
//  RecommendViewController.swift
//  DouYuWL0801
//
//  Created by dinpay on 2017/8/3.
//  Copyright © 2017年 com.vinlor. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {
    
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()



}

extension RecommendViewController {
    override func loadData() {
       self.baseVM = recommendVM
        
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendVM.anchorgroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
            
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
