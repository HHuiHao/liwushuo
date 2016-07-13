//
//  UISearchBar+Extension.swift
//  Liwushuo
//
//  Created by hans on 16/7/9.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

extension UISearchBar {

    convenience init(searchGifdelegate: UISearchBarDelegate, backgroundColor: UIColor, backgroundImage: UIImage) {
        self.init()
        delegate = searchGifdelegate
        placeholder = "快选一份礼物，送给亲爱的Ta吧"
        tintColor = UIColor.whiteColor()
        barStyle = UIBarStyle.BlackTranslucent
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        self.backgroundImage = backgroundImage
        for subView in subviews {
            for subView1 in subView.subviews {
                if subView1.isKindOfClass(UITextField) {
                    subView1.backgroundColor = backgroundColor
                }
            }
            
        }
    }
}
