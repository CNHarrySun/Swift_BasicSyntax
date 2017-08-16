//
//  ComposeTextView.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    
    // MARK:- 懒加载属性
    lazy var placeHolderLabel : UILabel = UILabel()
    
    // MARK:- 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

// MARK:- 设置UI界面
extension ComposeTextView {
    
    fileprivate func setupUI(){
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        
        // 设置内容的内边距
        textContainerInset = UIEdgeInsets(top: 7, left: 7, bottom: 0, right: 10)
    }
}
