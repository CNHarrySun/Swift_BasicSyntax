//
//  ViewController.swift
//  Swift_自定义Log
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 1.获取打印所在的文件
//        // lastPathComponent：获取最后一个路径
//        let file = (#file as NSString).lastPathComponent
//        
//        // 2.获取打印所在的方法
//        let funcName = #function
//        
//        // 3.获取打印所在行数
//        let lineNum = #line
//        
//        
//        print("\(file):[\(funcName)](\(#line)) - 123")
//        print("\(file):[\(funcName)](\(#line)) - 123")
        
        
        SHLog(message: 123)
        
//        print("ViewController - 123")
        
    }
    

    
    
}

