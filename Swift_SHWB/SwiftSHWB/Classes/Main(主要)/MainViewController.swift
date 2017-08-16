//
//  MainViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK:- 懒加载属性
    lazy var composeBtn:UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
//    UIButton.createButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposBtn()
    }
    /*
//    // 下面这些代码如果放在viewDidLoad里面，会在viewWillAppear调整回来（调整tabbar都是在viewWillAppear里面调整的）
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        setupTabbarItems()
//    }
 */
}


// MARK:- 设置UI界面
extension MainViewController {
    
    // 设置发布按钮
    func setupComposBtn() {
        
        // 1.将composeBtn添加到tabbar中
        tabBar.addSubview(composeBtn)
        // 2.设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        // 3.监听发布按钮的点击
        // Selector两种写法：1>Selector("方法名")  2>"方法名"
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
    }
    /*
    // 设置item
    func setupTabbarItems() {
        
        // 1.遍历所有的item
        for i in 0..<tabBar.items!.count{
            // 2.获取item
            let item = tabBar.items![i]
            
            // 3.如果下标值为2，则该item不可以和用户交互
            if i == 2 {
                item.isEnabled = false
                continue
            }
            
            // 4.设置其他item的选中时候的图片
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
    }
    */
}

// MARK:- 事件监听
extension MainViewController {
    
    // 事件监听本质发送消息，但是发送消息是OC的特性
    // 将方法包装成@SEL --> 类中查找方法列表 --> 根据@SEL找到imp指针（函数指针）--> 执行函数
    // 如果Swift中将一个函数声明为private，那么该函数不会被添加到方法列表中
    // 如果在private前面加上@objc，那么该方法依然会被添加到方法列表中
    func composeBtnClick() {
        let composeVC = ComposeViewController()
        let composeNav = UINavigationController(rootViewController: composeVC)
        present(composeNav, animated: true, completion: nil)
    }
}


