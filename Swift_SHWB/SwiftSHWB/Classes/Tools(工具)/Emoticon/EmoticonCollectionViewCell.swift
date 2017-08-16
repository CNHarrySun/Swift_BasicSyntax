//
//  EmoticonCollectionViewCell.swift
//  Swift_表情键盘
//
//  Created by HarrySun on 2017/8/9.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class EmoticonCollectionViewCell: UICollectionViewCell {
    // MARK:- 懒加载
    fileprivate lazy var emoticonBtn : UIButton = UIButton()
    
    // MARK:- 定义的属性
    var emoticon : Emoticon?{
        didSet{
            guard let emoticon = emoticon else {
                return
            }
            // 1.设置emoticonBtn的内容
            emoticonBtn.setImage(UIImage(contentsOfFile:emoticon.pngPath ?? ""), for:.normal)
            emoticonBtn.setTitle(emoticon.emojiCode, for: .normal)
            
            // 2.设置删除按钮
            if emoticon.isRemove {
                emoticonBtn.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面内容
extension EmoticonCollectionViewCell {
    fileprivate func setupUI(){
        
        contentView.addSubview(emoticonBtn)
        emoticonBtn.frame = contentView.bounds
        emoticonBtn.isUserInteractionEnabled = false
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
