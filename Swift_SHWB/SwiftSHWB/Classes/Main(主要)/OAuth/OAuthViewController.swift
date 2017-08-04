//
//  OAuthViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    // MARK:- 控件的属性
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置导航栏的内容
        setupNavigationBar()
        
        // 2.加载网页
        loadPage()
        
    }

}

// MARK:- 设置UI界面相关
extension OAuthViewController {
    
    func setupNavigationBar(){
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.closeItemClick))
        // 2.设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(OAuthViewController.fillItemClick))
        // 3.设置标题
        title = "登录界面"
    }
}

// MARK:- 事件监听函数
extension OAuthViewController{
    
    func closeItemClick(){
        
        dismiss(animated: true, completion: nil)
    }
    func fillItemClick(){
        // 1.书写js代码：JavaScript / java --> 雷锋和雷峰塔之间的区别
        let jsCode = "document.getElementById('userId').value='zhanghao';document.getElementById('passwd').value='mima';"
        // 2.执行js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
    
    func loadPage(){
        
        // 1.获取登陆页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        // 2.创建对应的URL
        guard let url = URL(string: urlString) else{
            return
        }
        // 3.创建URLRequest对象
        let request = URLRequest(url: url)
        
        // 4.加载网页
        webView.loadRequest(request)
    }
}

// MARK:- webView的delegate方法
extension OAuthViewController : UIWebViewDelegate{
    // webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    // webView网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    // webView加载网页失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    // 当准备加载某一个页面时，会执行该方法
    // 返回值：true --> 继续加载该页面  false --> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 1.获取加载网页的URL
        guard let url = request.url else{
            return true
        }
        // 2.获取URL中的字符串
        let urlString = url.absoluteString
        // 3.判断该字符串中是否包含code
        guard urlString.contains("code=")else{
            return true
        }
        // 4.将code截取出来
        let code = urlString.components(separatedBy: "code=").last!
        // 5.请求accessToken
        loadAccessToken(code: code)
        return false
    }
}

// MARK:- 请求数据
extension OAuthViewController{
    // 请求AccessToken
    func loadAccessToken(code:String){
        NetworkTools.shareInstance.loadAccessToken(code: code) { (result, error) in
            // 1.错误校验
            if error != nil{
                print(error!)
                return
            }
            // 2.拿到结果
            guard let accountDict = result else{
                print("没有获取授权后的数据")
                return
            }
            // 3.将字典转成模型对象
            let account = UserAccount(dict: accountDict)
            // 4.请求用户信息
            self.loadUserInfo(account: account)
        }
    }
    
    // 请求用户信息
    func loadUserInfo(account : UserAccount){
        // 1.获取AccessToken
        guard let accessToken = account.access_token else{
            return
        }
        // 2.获取uid
        guard let uid = account.uid else {
            return
        }
        NetworkTools.shareInstance.loadUserInfo(access_token: accessToken, uid: uid) { (result, error) in
            // 1.错误校验
            if error != nil{
                print(error!)
                return
            }
            // 2.拿到用户信息的结果
            guard let userInfoDict = result else{
                return
            }
            // 3.从字典中取出昵称和用户头像地址
            account.screen_name =  userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            // 4. 将account对象保存
            // 4.1.获取沙盒路径
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            accountPath = accountPath.appending("account.plist")
            accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
            // 4.2.保存对象
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
        }
    }
}

