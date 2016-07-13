//
//  HotViewController.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit
import MJRefresh
class HotViewController: BaseGoodsFeedViewController {
    
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefresh()
    }
    
    private func setupUI() {
        title = "热门"
        view.backgroundColor = Color_GlobalBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(searchTarget: self, action: #selector(HotViewController.searchBtnAction))
    }
    
    private func setupRefresh() {
        let header = Refresh(refreshingTarget: self, refreshingAction: #selector(HotViewController.pullDownLoadData))
        collectionView.mj_header = header
    }
    
    @objc private func pullDownLoadData() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.collectionView.mj_header.endRefreshing()
        }
    }
    
    @objc private func searchBtnAction() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}
