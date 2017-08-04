//
//  SHPresentationController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class SHPresentationController: UIPresentationController {

    // MARK:- 对外提供属性
    var presentedFrame:CGRect = CGRect.zero
    
    
    // MARK:- 懒加载属性
    lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 1.设置弹出View的尺寸
        presentedView?.frame = presentedFrame
        
        // 2.添加蒙版
        setupCoverView()
    }
}


// MARK:- 设置U界面相关
extension SHPresentationController {
    func setupCoverView(){
        // 1.添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        // 2.设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        coverView.frame = containerView!.bounds
        // 3.添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

// MARK:- 事件监听
extension SHPresentationController {
    func coverViewClick(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}





