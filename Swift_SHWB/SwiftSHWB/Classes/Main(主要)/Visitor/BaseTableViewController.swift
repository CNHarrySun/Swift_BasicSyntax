//
//  BaseTableViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/2.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // MARK:- 懒加载属性
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    // MARK:- 定义变量
    var isLogin : Bool = false
    
    // MARK:- 系统回调函数
    override func loadView() {
        
        // 1.从沙盒中读取归档的信息
        // 1.1.获取沙盒路径
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
        // 1.2.读取信息
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        
        if let account = account {
            // 1.3.取出过期日期：当前日期
            if let expiresDate = account.expires_date {
                isLogin = expiresDate.compare(Date()) == ComparisonResult.orderedDescending
            }
            
            isLogin = true
        }
        
        // 判断要加载哪一个View
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
    }
}


// MARK:- 设置UI界面
extension BaseTableViewController {
    
    // 设置访客视图
    func setupVisitorView(){
        
        view = visitorView
        
        // 监听访客视图中“注册”和“登录”按钮的点击
        visitorView.registerBtn.addTarget(self, action: #selector(BaseTableViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseTableViewController.loginBtnClick), for: .touchUpInside)
    }
    
    // 设置导航栏左右的Item
    func setupNavigationItems(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseTableViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(BaseTableViewController.loginBtnClick))
    }
    
}


// MARK:- 事件监听
extension BaseTableViewController{
    
    func registerBtnClick(){
        print("registerBtnClick")
    }
    func loginBtnClick(){
        // 1.创建授权控制器
        let oauthVC = OAuthViewController()
        // 2.包装导航栏控制器
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        // 3.弹出控制器
        present(oauthNav, animated: true, completion: nil)
    }
}

