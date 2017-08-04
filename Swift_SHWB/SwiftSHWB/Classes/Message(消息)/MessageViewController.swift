//
//  MessageViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class MessageViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", title: "登陆后，别人评论你的微博，给你发消息，都会在这里收到通知")

    }
}
