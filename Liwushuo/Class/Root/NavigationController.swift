//
//  NavigationController.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer!.delegate = nil;

        let appearance = UINavigationBar.appearance()
        appearance.translucent = false
        appearance.setBackgroundImage(UIImage.imageWithColor(Color_NavBackground, size: CGSizeMake(1, 1)), forBarMetrics: UIBarMetrics.Default)
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        appearance.titleTextAttributes = textAttrs
    }

    lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(NavigationController.backBtnAction))
    
    func backBtnAction() {
        self.popViewControllerAnimated(true)
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
