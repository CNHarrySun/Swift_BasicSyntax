//
//  ViewController.swift
//  Swift_异常捕捉
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 如果在调用系统某一个方法时，该方法最后有一个throws，说明该方法会抛出异常，那么需要对该异常进行处理
        /*
         在swift中提供三种处理异常的方式
         方式一：try方式 程序员手动捕捉异常
         do{
         let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
         }catch{
         catch：捕捉异常
         error：异常的对象
         print(error)
         }
         
         方式二：try?方式（常用方式） 系统帮助我们处理异常，如果该方法出现了异常，则该方法返回nil；如果没有异常，则返回对应的对象
         guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else{
         return
         }
         
         方式三：try!方式(不建议，非常危险) 直接告诉系统，该方法没有异常。注意：如果该方法出现了异常，那么程序会报错（崩溃）
         let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
         
         */
        
        
        // 1.创建正则表达式的规则
        let pattern = "abc"
        
        // 2.创建正则表达式对象
        
        // 方式一：try方式
        //        do{
        //            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        //        }catch{
        //            print(error)
        //        }
        
        // 方式二：try?方式
        //        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else{
        //            return
        //        }
        
        
        // 方式三：try!方式（危险）
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        
        
        
    }


}

