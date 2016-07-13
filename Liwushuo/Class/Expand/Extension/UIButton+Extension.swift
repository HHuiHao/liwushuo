//
//  UIButton+Extension.swift
//  Liwushuo
//
//  Created by hans on 16/6/30.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(x: CGFloat, iconName: NSString, target: AnyObject?, action: Selector, imageEdgeInsets: UIEdgeInsets){
        self.init()
        frame = CGRect(x: x, y: 0, width: 44, height: 44)
        setImage(UIImage(named: iconName as String), forState: UIControlState.Normal)
        setImage(UIImage(named: iconName as String), forState: UIControlState.Highlighted)
        self.imageEdgeInsets = imageEdgeInsets
        addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏排序按钮
    convenience init(sortTarget: AnyObject?, action: Selector) {
        self.init()
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        setImage(UIImage(named: "icon_sort"), forState: UIControlState.Normal)
        addTarget(sortTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏返回按钮
    convenience init(backTarget: AnyObject?, action: Selector) {
        self.init()
        setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        addTarget(backTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 导航栏取消按钮
    convenience init(cancelTarget: AnyObject?, action: Selector) {
        self.init()
        setTitle("取消", forState: UIControlState.Normal)
        frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        addTarget(cancelTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 选礼神器-筛选标签按钮
    convenience init(srotTagTarget: AnyObject?, action: Selector) {
        self.init()
        setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
        setBackgroundImage(UIImage.imageWithColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), size: CGSizeMake(1, 1)), forState: UIControlState.Selected)
        setBackgroundImage(UIImage.imageWithColor(UIColor.redColor(), size: CGSizeMake(1, 1)), forState: UIControlState.Highlighted)
        setTitleColor(UIColor (red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        titleLabel?.font = UIFont.systemFontOfSize(14.0)
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor (red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0).CGColor
        layer.borderWidth = 0.5
        addTarget(srotTagTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
}
