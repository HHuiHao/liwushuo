//
//  MeViewController.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit
import SnapKit

private let cellReuseIdentifier = "Cell"
class MeViewController: BaseViewController{
    
    var tableview : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - 视图
    private func setupUI(){
        hideNavigationBar(false)
        setupBarView()
        setupTableView()
    }
    
    /**
     隐藏导航条
     
     - parameter showBgImage: 是否显示导航条背景
     */
    private func hideNavigationBar(showBgImage: Bool){
        automaticallyAdjustsScrollViewInsets = false;
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.setBackgroundImage(showBgImage ? UIImage(named: "me_profilebackground") : UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    /**
     布局导航栏按钮
     */
    private func setupBarView(){
        
        let mailButton = UIButton(x: 0, iconName: "me_message", target:self, action:#selector(MeViewController.mailBtnAction), imageEdgeInsets: UIEdgeInsetsMake(0, -20, 0, 0))
        let alarmclockButton = UIButton(x: 44, iconName: "me_giftremind", target:self, action: #selector(MeViewController.alarmclockBtnAction), imageEdgeInsets: UIEdgeInsetsMake(0, -20, 0, 0))
        leftBarView .addSubview(mailButton)
        leftBarView.addSubview(alarmclockButton)
        
        let qrcodeButton = UIButton(x: 0, iconName: "me_scan", target:self, action:#selector(MeViewController.qrcodeBtnAction), imageEdgeInsets: UIEdgeInsetsMake(0, 0, 0, -20))
        let settingButton = UIButton(x: 44, iconName: "iconSettings", target:self, action: #selector(MeViewController.settingBtnAction), imageEdgeInsets: UIEdgeInsetsMake(0, 0, 0, -20))
        rightBarView .addSubview(qrcodeButton)
        rightBarView.addSubview(settingButton)
        
        let leftBarItem = UIBarButtonItem()
        let rightBarItem = UIBarButtonItem()
        leftBarItem.customView = leftBarView
        rightBarItem.customView = rightBarView
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    /**
     布局tableview
     */
    private func setupTableView(){
        
        /// 初始化tableview
        tableview = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableview?.backgroundColor = Color_GlobalBackground
        tableview?.sectionHeaderHeight = 0
        tableview?.sectionFooterHeight = 0
        view.addSubview(tableview!)
        /// tableview头部
        tableview?.tableHeaderView = headerView
        /// tableview底部
        tableview?.tableFooterView = footerView
    }

    // MARK: - 懒加载
    private lazy var leftBarView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
    }()
    
    private lazy var rightBarView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 44))
    }()
    
    private lazy var headerView: MeHeaderView = {
       return MeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 214 + 70))
    }()
    
    private lazy var footerView: MeFooterView = {
        return MeFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300))
    }()
    
    private lazy var sectionView: UIView = {
        let nibs: NSArray = NSBundle.mainBundle().loadNibNamed("MeSectionView", owner: nil, options: nil)
        let view = nibs.lastObject as! UIView
        view.frame = CGRect(x: 0, y: 0, width: self.tableview!.bounds.width, height: 60)
        return view
    }()
    
    // MARK: - 事件
    @objc private func mailBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
    
    @objc private func alarmclockBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
    
    @objc private func qrcodeBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
    
    @objc private func settingBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
}

// MARK: - 代理
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /// 处理背景图片拉伸效果
        let offsetY = scrollView.contentOffset.y;
        if offsetY > 0 {
            return
        }
        let upFactor: CGFloat = 0.6;
        if offsetY >= 0.0 {
            headerView.bgimageView.transform = CGAffineTransformMakeTranslation(0, offsetY * upFactor)
        } else {
            let transform = CGAffineTransformMakeTranslation(0, offsetY)
            let s = 1 + -offsetY * 0.01
            headerView.bgimageView.transform = CGAffineTransformScale(transform, 1, s)
        }
        
    }
}
