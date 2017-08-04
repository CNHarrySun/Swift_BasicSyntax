//
//  UIBarButtonItem-Extension.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/2.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /*
    convenience init(imageName : String){
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.customView = btn
    }
 */
    
    
    convenience init(imageName : String){
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView:btn)
    }
    
}
