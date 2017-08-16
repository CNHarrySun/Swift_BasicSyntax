//
//  UserAccountTool.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class UserAccountViewModel{

    // MARK:- 将类设计成单例
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK:- 定义属性
    var account : UserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    var isLogin : Bool{
        if account == nil{
            return false
        }
        guard let expiresDate = account?.expires_date else{
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    // MARK:- 重写init()函数
    
    init(){
        // 1.从沙盒中读取归档的信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    
}
