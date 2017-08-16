//
//  PicPickerViewCell.swift
//  SwiftSHWB
//
//  Created by HarrySun on 2017/8/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {

    // MARK:- 控件的属性
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var removePhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK:- 定义属性
    var image : UIImage? {
        didSet{
            if image != nil {
                imageView.image = image
                addPhotoBtn.isUserInteractionEnabled = false
                removePhotoBtn.isHidden = false
            }else{
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                removePhotoBtn.isHidden = true
            }
        }
    }
    
    // MARK:- 事件监听
    @IBAction func addPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: picPickerAddPhotoNote), object: nil)
    }
    
    @IBAction func removePhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:picPickerRemovePhotoNote), object: imageView.image)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
