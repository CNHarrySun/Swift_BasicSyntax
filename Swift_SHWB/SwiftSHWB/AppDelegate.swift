//
//  AppDelegate.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var  defaultViewController : UIViewController?{
        let isLogin = UserAccountViewModel.shareIntance.isLogin
        return isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        // 创建Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

