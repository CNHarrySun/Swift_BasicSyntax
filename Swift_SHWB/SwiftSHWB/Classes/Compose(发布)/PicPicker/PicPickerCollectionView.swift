//
//  PicPickerCollectionView.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
fileprivate let picPikcerCell = "picPicekrCell"
fileprivate let edgeMargin : CGFloat = 15

class PicPickerCollectionView: UICollectionView {
    
    // MARK:- 定义属性
    var images : [UIImage] = [UIImage](){
        didSet{
            reloadData()
        }
    }
    
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置collectionView的layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.size.width - 4 * edgeMargin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        
        
        register(UINib(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPikcerCell)
        dataSource = self
        
        // 设置collectionView的内边距
        contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: 0, right: edgeMargin)
    }
}

extension PicPickerCollectionView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPikcerCell, for: indexPath) as! PicPickerViewCell
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        return cell
    }
}
