//
//  ProfileViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", title: "登陆后，你的微博、相册、个人资料会显示在这里，展示给别人")

    }

}
