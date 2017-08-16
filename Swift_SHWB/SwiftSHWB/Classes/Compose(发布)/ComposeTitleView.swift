//
//  ComposeTitleView.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabel : UILabel = UILabel()
    fileprivate lazy var screenNameLabel : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(doer:)has not been implemented")
    }
}

// MARK:- 设置UI
extension ComposeTitleView{
    fileprivate func setupUI(){
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }

        screenNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        screenNameLabel.textColor = UIColor.lightGray
        
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
}
