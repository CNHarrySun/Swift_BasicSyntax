//
//  UITextView-Extension.swift
//  Swift_表情键盘
//
//  Created by HarrySun on 2017/8/16.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

extension UITextView {
    
    // 获取textView属性字符串，对应的表情字符串
    func getEmoticonString() -> String{
        // 1.获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString:attributedText)
        // 2.遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length)
        attrMStr.enumerateAttributes(in: range, options: []) { (dict, range, _) in
            if let attachment = dict["NSAttachment"] as? EmoticonAttachment{
                attrMStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        
        // 3.获取字符串
        return attrMStr.string
    }
    
    // 给textView插入表情
    func insertEmoticon(emoticon : Emoticon) {
        // 1.空白表情
        if emoticon.isEmpty {
            return
        }
        // 2.删除按钮
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        // 3.emoji表情
        if emoticon.emojiCode != nil {
            // 3.1获取光标所在的位置：UITextRange
            let textRange = selectedTextRange!
            // 3.2替换emoji表情
            replace(textRange, withText: emoticon.emojiCode!)
            return
        }
        // 4.普通表情：图文混排
        // 4.1 根据图片路径创建属性字符串
        let attachment = EmoticonAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attrImageStr = NSAttributedString(attachment: attachment)
        // 4.2 创建可变的属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        // 4.3 讲图片属性字符串替换到可变属性字符串的某一个位置
        // 4.3.1 获取光标所在的位置
        let range = selectedRange
        attrMStr.replaceCharacters(in: range, with: attrImageStr)
        // 显示属性字符串
        attributedText = attrMStr
        
        // 将文字的大小(文字大小会变化)
        self.font = font
        // 将光标设置回原来的位置 + 1(光标位置会回到最后)
        selectedRange = NSRange(location: range.location + 1, length: 0)

    }
}
