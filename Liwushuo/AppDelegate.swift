//
//  AppDelegate.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//-----------------------------------------------------
//  我的微博:    http://weibo.com/2613667282/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1
//  微信公众号：hans_iOS (有问题，直接发送到公众号里，我会及时回复)

//  项目讲解Blog:   http://www.jianshu.com/users/368a8cd349af/latest_articles
//  项目地址(GitHub): http://weibo.com/2613667282/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1
//------------------------------------------------------

import UIKit
import SVProgressHUD
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 设置全局nav与tab色值
        UINavigationBar.appearance().tintColor = UIColor.init(red: 255.0/255.0, green: 2.0/255.0, blue: 51.0/255, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.init(red: 255.0/255.0, green: 2.0/255.0, blue: 51.0/255, alpha: 1.0)
        
        // 创建窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        SVProgressHUD.setBackgroundColor(UIColor.blackColor())
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

