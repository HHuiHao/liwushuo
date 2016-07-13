//
//  SingleGifColumnCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/11.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class SingleGifColumnCell: UITableViewCell {

    @IBOutlet weak var edgeLineView: UIView!
    @IBOutlet weak var titleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        edgeLineView.hidden = true
        titleBtn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        titleBtn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), forState: UIControlState.Selected)
        
        titleBtn.setBackgroundImage(UIImage.imageWithColor(Color_GlobalBackground, size: CGSizeZero), forState: UIControlState.Normal)
        titleBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeZero), forState: UIControlState.Selected)
    }
    
    func changeStatus(selected: Bool) {
        titleBtn.selected = selected
        edgeLineView.hidden = !selected
    }
}
