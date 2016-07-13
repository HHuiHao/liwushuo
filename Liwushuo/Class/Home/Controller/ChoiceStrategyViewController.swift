//
//  ChoiceStrategyViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/8.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class ChoiceStrategyViewController: BaseStrategyFeedController {

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
        headerView.addSubview(banner)
        headerView.addSubview(topic)
        tableView.tableHeaderView = headerView
    }

    private func setupUIFrame() {
        banner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 170.0)
        topic.frame = CGRect(x: 0, y: banner.bounds.height, width: tableView.bounds.width, height: 120.0)
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: banner.bounds.height + topic.bounds.height + 10.0)
        /// 设置完高度需要重新赋值，否则高度不准确
        tableView.tableHeaderView = headerView
    }

    // MARK: - 懒加载
    private lazy var headerView: UIView = UIView()
    
    private lazy var banner:BannerCollectionView =  BannerCollectionView(frame: CGRectZero, collectionViewLayout: BannerFlowLayout())
    
    private lazy var topic:TopicCollectionView =  TopicCollectionView(frame: CGRectZero, collectionViewLayout: TopicFlowLayout())
}
