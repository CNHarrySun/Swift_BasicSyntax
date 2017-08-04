//
//  TitleButton.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/2.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    // MARK:- 重写init函数
    override init(frame:CGRect){
        super.init(frame:frame)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)        
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
        
    }
    
    // Swift中规定：重写控件的init(frame)方法或者init()方法，必须重写init?(coder aDecoder: NSCoder)
    // required：必须实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
    
}
