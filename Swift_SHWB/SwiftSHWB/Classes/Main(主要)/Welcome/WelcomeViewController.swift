//
//  WelcomeViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/4.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    // MARK:- 拖线的属性
    @IBOutlet weak var iconViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 0.设置头像
        let profileURLString = UserAccountViewModel.shareIntance.account?.avatar_large
        // ??：如果??前面的可选类型有值，那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil，那么直接使用??后面的值
        let url = URL(string: profileURLString ?? "avatar_default_big")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        // 1.改变约束的值
        iconViewBottomConstraints.constant = UIScreen.main.bounds.height - 200
        
        // 2.执行动画
        // Damping：阻力系数，阻力系数越大，弹动效果越不明显 0~1
        // initialSpringVelocity：初始化速度
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
