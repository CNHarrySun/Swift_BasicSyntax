//
//  NetworkTools.swift
//  AFNetWorking的封装
//
//  Created by HarrySun on 2017/8/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import AFNetworking

// 定义枚举类型(可以使Int类型/String类型)
enum RequestType:String{
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    // 创建单例
    // let是线程安全的
    static let shareInstance : NetworkTools = {
       
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}

// MARK:- 封装请求方法
extension NetworkTools{
    
    func request(methodType:RequestType, urlString:String, parameters:[NSString:Any], finished: @escaping (_ result:Any?,_ error:Error?)->()){
        
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask, result:Any) in
            finished(result, nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task:URLSessionTask?, error:Error) in
            finished(nil, error)
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }else{
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
    
    
    
}


// MARK:- 请求AccessToken
extension NetworkTools{
    
    func loadAccessToken(code : String, finished : @escaping (_ result : [String :  Any]?, _ error : Error?) -> ()){
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/oauth2/access_token"
        // 2.获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : App_Secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        // 3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters as [NSString : Any]) { (result, error) in
            finished(result as? [String : Any], error)
        }
    }
}

// MARK:- 请求用户的信息
extension NetworkTools {
    
    func loadUserInfo(access_token : String,uid:String, finished : @escaping ( _ result : [String : Any]?,_ error:Error?) -> ()){
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token" : access_token,"uid" : uid]
        request(methodType: .GET, urlString: urlString, parameters: parameters as [NSString : Any]) { (result, error) in
            finished(result as? [String : Any], error)
        }
    }
}

