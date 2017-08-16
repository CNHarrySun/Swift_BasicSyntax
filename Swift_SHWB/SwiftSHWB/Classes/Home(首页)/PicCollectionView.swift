//
//  PicCollectionView.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/7.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class PicCollectionView: UICollectionView {
    
    // MARK:- 定义属性
    var picURLs : [URL] = [URL](){
        didSet{
            self.reloadData()
        }
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }
}


// MARK:- collectionView的数据源方法
extension PicCollectionView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.picURL = picURLs[indexPath.item]
        return cell
    }
}

class PicCollectionViewCell: UICollectionViewCell {
    
    // MARK:- 定义模型属性
    var picURL : URL? {
        didSet{
            guard let picURL = picURL else {
                return
            }
            iconView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    // MARK:- 控件的属性
    @IBOutlet weak var iconView: UIImageView!
    
    
}

