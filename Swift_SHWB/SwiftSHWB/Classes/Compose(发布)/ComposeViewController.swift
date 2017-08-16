//
//  ComposeViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComposeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleView : ComposeTitleView = ComposeTitleView()
    fileprivate lazy var images : [UIImage] = [UIImage]()
    fileprivate lazy var emoticonVC : EmoticonViewController = EmoticonViewController {[weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon: emoticon)
        self?.textViewDidChange(self!.textView)     // 因为插入表情的时候不会触发textViewDidChange方法，所以需要手动调用下
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var picPickerView: PicPickerCollectionView!
    

    
    // MARK:- 约束的属性
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHCons: NSLayoutConstraint!
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        setupNavigationBar()
        // 监听通知
        setupNotifications()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK:- 设置UI界面
extension ComposeViewController{
    fileprivate func setupNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
    }
    
    fileprivate func setupNotifications(){
        // 监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChangeFrame), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        // 监听添加图片的按钮点击
        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoClick), name: NSNotification.Name(rawValue: picPickerAddPhotoNote), object: nil)
        // 监听删除图片的按钮点击
        NotificationCenter.default.addObserver(self, selector: #selector(removePhotoClick), name: NSNotification.Name(rawValue: picPickerRemovePhotoNote), object: nil)
    }
    
}

// MARK:- 事件监听函数
extension ComposeViewController{
    
    @objc fileprivate func closeItemClick(){
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc fileprivate func sendItemClick(){
        // 0.键盘退出
        textView.resignFirstResponder()
        // 1.获取发送微博正文
        let statusText = textView.getEmoticonString()
        // 2.调用接口发送微博
        NetworkTools.shareInstance.sendStatus(statusText: statusText) { (isSuccess) in
            if !isSuccess {
                SVProgressHUD.showSuccess(withStatus: "发送微博失败")
                return
            }
            SVProgressHUD.showSuccess(withStatus: "发送微博成功")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func KeyboardWillChangeFrame(note : Notification) {
        // 1.获取动画执行的时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 2.获取键盘最终Y值
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        // 3.计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - y
        // 4.执行动画
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func picPickerBtnClick(_ sender: Any) {
        // 退出键盘
        textView.resignFirstResponder()
        // 执行动画
        picPickerViewHCons.constant = UIScreen.main.bounds.height * 0.65
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func emoticonBtnClick() {
        // 1.退出键盘
        textView.resignFirstResponder()
        // 2.切换键盘
        textView.inputView = textView.inputView != nil ? nil  : emoticonVC.view
        // 3.弹出键盘
        textView.becomeFirstResponder()
    }
    
}

// MARK:- 添加照片和删除照片的事件
extension ComposeViewController{
    
    @objc fileprivate func addPhotoClick(){
        
        // 1.判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            return
        }
        // 2.创建照片选择控制器
        let ipc = UIImagePickerController()
        
        // 3.设置照片源
        ipc.sourceType = .photoLibrary
        // 4.设置代理
        ipc.delegate = self
        // 5.弹出选择照片的控制器
        present(ipc, animated: true, completion: nil)
    }
    
    @objc fileprivate func removePhotoClick(note : Notification){
        // 1.获取image对象
        guard let image = note.object as? UIImage else{
            return
        }
        
        // 2.获取image对象所在的下标值
        guard let index =  images.index(of: image) else{
            return
        }
        // 3.将图片从数组中删除
        images.remove(at: index)
        // 4.重新赋值collectionView新的数组
        picPickerView.images = images
    }
}

// MARK:- UIImagePickerController的代理方法
extension ComposeViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 1.获取选中的图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // 2.将选中的图片添加到数组中
        images.append(image)
        // 3.将数组赋值给collectionView，让collectionView展示数据
        picPickerView.images = images
        
        // 4.退出选中图片控制器
        picker.dismiss(animated: true, completion: nil)
    }
}



// MARK:- UITextViewDelegate
extension ComposeViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}


