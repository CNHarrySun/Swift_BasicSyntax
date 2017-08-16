//
//  HomeViewController.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/1.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeViewController: BaseTableViewController {

    
    // MARK:- 懒加载属性
    lazy var titleBtn:TitleButton = TitleButton()
    
    // 注意：在闭包中如果使用当前对象的属性或者调用方法，也需要加self
    // 两个地方需要使用self： 1>如果再一个函数中出现了歧义 2>在闭包中使用当前对象的属性和方法也需要加self
    // 这里会产生循环引用，所以在参数前加上[weak self]
    lazy var popoverAnimator:PopoverAnimator = PopoverAnimator {[weak self] (presented) in
        
        self?.titleBtn.isSelected = presented
    }
    
    lazy var viewModels : [StatusViewModel] = [StatusViewModel]()
    fileprivate lazy var tipLabel : UILabel = UILabel()
    
    
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
        
        // 3.请求数据
        loadStatues(isNewData: true)
        
//        // 自动适配约束(两个属性需要同时设置)
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 200
        
        // 4.设置估算高度
        tableView.estimatedRowHeight = 200
    
        // 5.布局header
        setupHeaderView()
        setupFooterView()
        setupTipLabel()
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
    
    func setupHeaderView(){
        
        // 1.创建header
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewStatuses))
        
        // 2.设置header的属性
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        
        // 3.设置tableView的header
        tableView.mj_header = header
        
        // 4.进入刷新状态
        tableView.mj_header.beginRefreshing()
    }
    
    func setupFooterView(){
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreStatuses))
    }
    
    func setupTipLabel(){
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        tipLabel.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: 32)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true
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

// MARK:- 请求数据
extension HomeViewController {
    
    // 加载最新数据
    func loadNewStatuses(){
        loadStatues(isNewData: true)
    }
    
    // 加载更多数据
    func loadMoreStatuses(){
        loadStatues(isNewData: false)
    }
    
    // 加载微博数据
    func loadStatues(isNewData : Bool) {
        
        // 1.获取since_id/max_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        }else{
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        // 请求数据
        NetworkTools.shareInstance.loadStatuses(since_id: since_id,max_id: max_id) { (result, error) in
            // 1.错误校验
            if error != nil{
                print(error!)
                return
            }
            // 2.获取可选类型中的数据
            guard let resultArray = result else{
                return
            }
            
            // 3.遍历微博对应的字典
            var tempViewModel = [StatusViewModel]()
            for statusDict in resultArray{
                
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                tempViewModel.append(viewModel)
            }
            // 4.将数据放入到成员变量的数组中
            if isNewData {
                self.viewModels = tempViewModel + self.viewModels
            }else{
                self.viewModels += tempViewModel
            }
            
            
            // 5.缓存图片
            self .cacheImages(viewModels: self.viewModels)
            
        }
    }
    
    func cacheImages(viewModels : [StatusViewModel]) {
        // 0.创建group
        let group = DispatchGroup()
        
        // 1.缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picURLs{
                group.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _) in
                    print("下载了一张图片")
                    group.leave()
                })
            }
        }
        // 2.刷新表格
        group.notify(queue: DispatchQueue.main) {
            
            // 刷新表格
            self.tableView.reloadData()
            // 停止刷新
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            // 显示提示的Label
            self.showTiplable(count: viewModels.count)
        }
    }
    
    // 显示提示的Label
    func showTiplable(count : Int){
        // 1.设置tipLabel的属性
        
        tipLabel.text = count == 0 ? "没有新数据" : "\(count)条新微博"
        // 2.执行动画
        UIView.animate(withDuration: 0.5, animations: {
            self.tipLabel.isHidden = false
            self.tipLabel.frame.origin.y = 44
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
                self.tipLabel.frame.origin.y = 10
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
    }
}

// MARK:- tableView的数据源方法
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellID") as! HomeViewCell
        // 2.给cell设置数据
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 1.获取模型对象
        let viewModel = viewModels[indexPath.row]
        return viewModel.cellHeight
    }
}


