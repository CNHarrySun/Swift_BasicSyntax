//
//  HomeViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    
    // MARK:- 懒加载属性
    lazy var titleBtn:TitleButton = TitleButton()
    
    // 注意：在闭包中如果使用当前对象的属性或者调用方法，也需要加self
    // 两个地方需要使用self： 1>如果再一个函数中出现了歧义 2>在闭包中使用当前对象的属性和方法也需要加self
    // 这里会产生循环引用，所以在参数前加上[weak self]
    lazy var popoverAnimator:PopoverAnimator = PopoverAnimator {[weak self] (presented) in
        
        self?.titleBtn.isSelected = presented
    }
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.没有登陆时设置的内容
        visitorView.addRotationAnim()
        
        if !isLogin{
            
            return
        }
        
        // 2.设置导航栏的内容
        setupNavigationBar()
    }
}

// MARK:- 设置UI界面
extension HomeViewController{
    
    func setupNavigationBar(){
        // 1.设置左侧的Item
        /*
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named:"navigationbar_friendattention"), for: .normal)
        leftBtn.setImage(UIImage(named:"navigationbar_friendattention_highlighted"), for: .highlighted)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
 */
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 2.设置右侧的Item
        /*
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named:"navigationbar_pop"), for: .normal)
        rightBtn.setImage(UIImage(named:"navigationbar_pop_highlighted"), for: .highlighted)
        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        */
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")

        // 3.设置titleView
        titleBtn.setTitle("CoderSun", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

// MARK:- 事件监听
extension HomeViewController {
    
    func titleBtnClick(titleBtn:TitleButton){
        
        
        // 1.创建弹出的控制器
        let popoverVC = PopoverViewController()
        
        // 2.设置控制器的modal样式
        popoverVC.modalPresentationStyle = .custom
        
        // 3.设置转场的代理
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x:100,y:55,width:180,height:250)
        
        // 4.弹出控制器
        present(popoverVC, animated: true, completion: nil)
    }
}



