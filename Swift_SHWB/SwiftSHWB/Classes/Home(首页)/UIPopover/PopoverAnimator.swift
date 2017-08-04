//
//  PopoverAnimator.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    
    // MARK:- 属性
    var isPresented : Bool = false
    var presentedFrame : CGRect = CGRect.zero
    
    // MARK:- 对外提供的属性
    var callBack : ((_ presented : Bool) -> ())?
    
//    override init(){
//        
//    }
    
    // MARK:- 自定义构造函数
    // 注意：如果自定义了一个构造函数，但是没有对父类的构造函数init()进行重写。那么自定义的构造函数会覆盖默认的init()构造函数
    init(callBack:@escaping (_ presented : Bool) -> ()) {
        self.callBack = callBack
    }
    
}


// MARK:- 自定义转场代理的方法
extension PopoverAnimator : UIViewControllerTransitioningDelegate{
    
    // 目的：改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = SHPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        return presentation
    }
    
    // 目的：自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        
        callBack!(isPresented)
        return self
    }
    
    // 目的：自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return self
    }
}

// MARK:- 弹出和消失动画代理的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning {
    // 动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    // 获取“转场的上下文”：可以通过转场上下文获取弹出的View和消失的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(using: transitionContext) : animationForDismissedView(using: transitionContext)
        
    }
    
    // 自定义弹出动画
    func animationForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        
        // 1.获取弹出的View
        let presentedView = transitionContext.view(forKey: .to)!
        // 2.将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        // 3.执行动画
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        // 修改锚点
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    // 自定义消失动画
    func animationForDismissedView(using transitionContext: UIViewControllerContextTransitioning){
        
        // 1.获取消失的View
        let dismissView = transitionContext.view(forKey: .from)
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
        }) { (_) in
            dismissView?.removeFromSuperview()
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
}
