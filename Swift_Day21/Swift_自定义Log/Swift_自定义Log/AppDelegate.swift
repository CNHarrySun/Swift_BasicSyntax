//
//  AppDelegate.swift
//  Swift_自定义Log
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SHLog(message: 1)
        return true
    }

}

// T是动态类型
func SHLog<T>(message: T,file:String = #file,funcName:String = #function,lineNum:Int = #line){
    
    #if DEBUG       // Build Settings --> swift flags --> 在debug后点击+ --> -D 自己起的名字
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(第\(lineNum)行) - \(message)")
    //        print("\(fileName):[\(funcName)](\(lineNum)) - \(message)")   // 会打印函数名
    
    #endif
}
