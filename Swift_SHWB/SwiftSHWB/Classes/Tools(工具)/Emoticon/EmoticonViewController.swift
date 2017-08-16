//
//  EmoticonViewController.swift
//  Swift_表情键盘
//
//  Created by HarrySun on 2017/8/9.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

fileprivate let EmoticonCell = "EmoticonCell"

class EmoticonViewController: UIViewController {

    // MARK:- 定义属性
    var emoticonCallBack : (_ emoticon : Emoticon) -> ()
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonCollectionViewLayout())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    fileprivate lazy var manager = EmoticonManager()
    
    // MARK:- 自定义构造函数
    init(emoticonCallBack : @escaping (_ emoticon : Emoticon) -> ()){
        self.emoticonCallBack = emoticonCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK:- 设置UI界面内容
extension EmoticonViewController {
    fileprivate func setupUI(){
        
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        collectionView.backgroundColor = UIColor.purple
        toolBar.backgroundColor = UIColor.darkGray
        
        // 2.设置子控件的frame
        // 代码实现Autolayout，要先禁止autoresizing功能，设置translatesAutoresizingMaskIntoConstraints为false，添加约束之前，一定要保证相关控件都已经在各自的父控件上
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        // VFL     
        let views = ["toolBar" : toolBar,"collectionView" : collectionView] as [String : Any]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        // 3.准备collectionView
        prepareForCollectionView()
        
        // 4.准备toolBar
        prepareForToolBar()
    }
    
    fileprivate func prepareForCollectionView(){
        collectionView.register(EmoticonCollectionViewCell.self, forCellWithReuseIdentifier: EmoticonCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    fileprivate func prepareForToolBar(){
        // 1.定义toolBar中的titles
        let titles = ["最近","默认","emoji","浪小花"]
        // 2.遍历标题，创建item
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick))
            item.tag = index
            index += 1
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
    }
    
    @objc fileprivate func itemClick(item : UIBarButtonItem) {
        // 1.获取点击的item的tag
        let tag = item.tag
        // 2.根据tag获取到当前租
        let indexPath = NSIndexPath(item: 0, section: tag)
        // 3.滚动到对应的位置
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
}


// MARK:- collectionView的数据源和代理方法
extension EmoticonViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = manager.packages[section]
        return package.emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! EmoticonCollectionViewCell
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        cell.emoticon = emoticon
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出点击的表情
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.row]
        // 2.将点击的表情插入最近分组中
        insertRecentlyEmoticon(emoticon: emoticon)
        
        // 3.讲表情回调给外界控制器
        emoticonCallBack(emoticon)
    }
    
    fileprivate func insertRecentlyEmoticon(emoticon : Emoticon){
        // 1.如果是空白表情或者删除按钮，不需要插入
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        // 2.删除一个表情
        if manager.packages.first!.emoticons.contains(emoticon){    // 原来有该表情
            let index = manager.packages.first?.emoticons.index(of: emoticon)!
            manager.packages.first?.emoticons.remove(at: index!)
        }else{  // 原来没有该表情
            manager.packages.first?.emoticons.remove(at: 19)
        }
        
        // 3.将emoticon插入最近分组中
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}


class EmoticonCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        // 1.计算itemWH
        let itemWH = UIScreen.main.bounds.width / 7
        
        // 2.设置layout属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        // 3.设置collectionView的属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        let insertMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: insertMargin, left: 0, bottom: insertMargin, right: 0)
    }
}

