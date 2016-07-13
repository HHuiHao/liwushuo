//
//  ColumnListViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/12.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

/// 顶部封面图高度
private let showImageHeight:CGFloat = 150.0
private let cellID = "ColumnListCell"
class ColumnListViewController: BaseViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIFrame()
    }
    
    // MARK: - 视图
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        navbarView.addSubview(titleLab)
        view.addSubview(navbarView)
        view.addSubview(backBtn)
    }
    
    private func setupUIFrame() {
        /// 导航栏
        navbarView.frame = CGRectMake(0, 0, ScreenWidth, 64.0)
        backBtn.frame = CGRectMake(10.0, 15.0, 44, 44)
        titleLab.sizeToFit()
        titleLab.frame = CGRectMake((navbarView.bounds.width - titleLab.bounds.width) * 0.5, (navbarView.bounds.height - titleLab.bounds.height) * 0.5 + 5.0, titleLab.bounds.width, titleLab.bounds.height)
        /// tableView
        tableView.frame = view.bounds
        tableViewHeader.bounds = CGRectMake(0, 0, tableView.bounds.width, 250.0)
        tableViewSection.bounds = CGRectMake(0, 0, tableView.bounds.width, 50.0)
    }
    
    // MARK: - 事件
    @objc private func backBtnAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - 懒加载
    private lazy var navbarView:UIView = {
       let navbarView = UIView()
        navbarView.backgroundColor = Color_NavBackground
        navbarView.alpha = 0.0
        return navbarView
    }()
    
    private lazy var backBtn: UIButton = UIButton(backTarget: self, action: #selector(ColumnListViewController.backBtnAction))
    
    private lazy var titleLab:UILabel = {
       let titleLab = UILabel()
        titleLab.text = "不打烊的礼物店"
        titleLab.textColor = UIColor.whiteColor()
        titleLab.font = UIFont.systemFontOfSize(17.0)
        titleLab.textAlignment = NSTextAlignment.Center
        return titleLab
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.registerNib(UINib(nibName: "ColumnListCell", bundle:
            NSBundle.mainBundle()), forCellReuseIdentifier: cellID)
        tableView.tableHeaderView = self.tableViewHeader
        return tableView
    }()
    
    private lazy var tableViewHeader:UIView = ColumnListHeader.columnListHeader()
    
    private lazy var tableViewSection:UIView = NSBundle.mainBundle().loadNibNamed("ColumnListSectionView", owner: nil, options: nil).last as! UIView

}

// MARK: - 代理
extension ColumnListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 93.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(CommonFetureViewController(), animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewSection
    }
}

extension ColumnListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        navbarView.alpha = offsetY / (showImageHeight - navbarView.bounds.height)
    }
}