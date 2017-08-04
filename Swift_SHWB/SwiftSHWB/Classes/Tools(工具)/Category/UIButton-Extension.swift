//
//  UIButton-Extension.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/2.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

    // 给UIButton加一个扩展
    extension UIButton{
        // swift中类方法是以class开头的方法，类似于OC中+开头的方法
        
        class func createButton(imageName:String,bgImageName:String) -> UIButton{
            // 1.创建Btn
            let btn = UIButton()
            // 2.设置btn属性
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
            btn.setBackgroundImage(UIImage(named:bgImageName), for: .normal)
            btn.setBackgroundImage(UIImage(named:bgImageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
            return btn
        }
 
 
    
    // 构造函数(构造函数是不需要写返回值的，系统会自动返回的)
    // convenience：便利，使用convenience修饰的构造函数叫做便利构造函数
    // 便利构造函数通常用在对系统的类进行构造函数的扩充时使用
    /*
     便利构造函数的特点：
        1.便利构造函数通常都是卸载extension里面
        2.便利构造函数init前面需要加载convenience
        3.在便利构造函数中需要明确的调用self.init()
     */
    convenience init(imageName:String,bgImageName:String){
        self.init()
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named:bgImageName), for: .normal)
        setBackgroundImage(UIImage(named:bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    
}
