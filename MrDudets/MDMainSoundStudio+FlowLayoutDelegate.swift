//
//  MDMainSoundStudio+FlowLayoutDelegate.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

extension MDMainSoundStudioViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfColumns = CGFloat(4)
        let itemWidth = (CGRectGetWidth((self.collectionView?.frame)!) - 1) / numberOfColumns
        
        let containerHeight = self.view.frame.height - itemWidth * 2.0
        self.containerViewConstraint.constant = containerHeight
        
        return CGSize.init(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}