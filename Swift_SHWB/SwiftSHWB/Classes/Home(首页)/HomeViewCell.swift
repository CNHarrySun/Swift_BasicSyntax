//
//  HomeViewCell.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/4.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    @IBOutlet weak var retweetedBgView: UIView!
    @IBOutlet weak var bottomToolView: UIView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewButtomCons: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedContentLabelTopCons: NSLayoutConstraint!
    
    // MARK:- 自定义属性
    var viewModel : StatusViewModel? {
        didSet{
            // 1.nil值校验
            guard let viewModel = viewModel else{
                return
            }
            // 2.设置头像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            // 3.设置认证图标
            verifiedView.image = viewModel.verifiedImage
            // 4.处理昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            // 5.会员图标
            vipView.image = viewModel.vipImage
            // 6.设置时间的label
            timeLabel.text = viewModel.createAtText
            // 7.设置来源
            if let sourceText = viewModel.sourceText {
                sourceLabel.text = "来自 " + sourceText
            }else{
                sourceLabel.text = nil
            }
            // 8.设置正文
            contentLabel.text = viewModel.status?.text
            
            // 设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            // 9.计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            
            // 10.将picURL数据传递给picView
            picView.picURLs = viewModel.picURLs
            
            // 11.设置转发微博的正文
            if viewModel.status?.retweeted_status != nil{
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name,let retweetText = viewModel.status?.retweeted_status?.text{
                    retweetedContentLabel.text = "@" + "\(screenName): " + retweetText
                    retweetedContentLabelTopCons.constant = 15
                }
                // 设置背景显示
                retweetedBgView.isHidden = false
            }else{
                // 1.设置转发微博的正文
                retweetedContentLabel.text = nil
                // 2.设置背景显示
                retweetedBgView.isHidden = true
                // 3.设置转发正文距离顶部的约束
                retweetedContentLabelTopCons.constant = 0
            }
            
            // 12.计算cell的高度
            if viewModel.cellHeight == 0 {
                // 12.1.强制布局
                layoutIfNeeded()
                // 12.2.获取底部工具栏的最大Y值
                viewModel.cellHeight = bottomToolView.frame.maxY
                
            }
        }
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置微博正文的宽度约束
        contentLabelWidthCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
        //        // 取出picView对应的layout
        //        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        //        let imageViewWH = (UIScreen.main.bounds.width - 2 * itemMargin - 2 * itemMargin) / 3
        //        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
    }
}

// MARK:- 计算方法
extension HomeViewCell {
    func calculatePicViewSize(count : Int) -> CGSize {
        // 1.没有配图
        if count == 0{
            picViewButtomCons.constant = 0
            return CGSize.zero
        }
        // 有配图需要该约束有值
        picViewButtomCons.constant = 10
        
        // 2.取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 3.单张配图
        if count == 1{
            // 1.取出图片
            let urlString = viewModel?.picURLs.last?.absoluteString
            if let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlString){   // imageFromDiskCache:从磁盘里取    imageFromMemoryCache:从内存里去
                // 2.设置一张图片时layout的itemSize
                layout.itemSize = CGSize(width: (image.size.width) * 2, height: (image.size.height) * 2)
                // 请求到图片宽度和高度
                return CGSize(width: (image.size.width) * 2, height: (image.size.height) * 2)
                
            }
            return CGSize.zero
        }
        
        // 4.计算出来imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * itemMargin - 2 * itemMargin) / 3
        // 5.设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 6.四张配图
        if count == 4{
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 7.其他张配图
        // 7.1.计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        // 7.2.计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        // 7.3.计算picView的宽度
        let picViewW = UIScreen.main.bounds.width - 2 * itemMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
}


