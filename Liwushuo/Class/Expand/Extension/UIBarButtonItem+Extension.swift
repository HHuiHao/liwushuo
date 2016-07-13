//
//  UIBarButtonItem+Extension.swift
//  Liwushuo
//
//  Created by hans on 16/7/7.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 礼物
    convenience init(gifTarget: AnyObject?, action: Selector){
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "feed_signin"), forState: UIControlState.Normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btn.addTarget(gifTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }
    
    /// 搜索
    convenience init(searchTarget: AnyObject?, action: Selector){
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "icon_navigation_search"), forState: UIControlState.Normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn.addTarget(searchTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }
    
    /// 选礼神器
    convenience init(chooseGifTarget: AnyObject?, action: Selector){
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn.setTitle("选礼神器", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.addTarget(chooseGifTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }
}
