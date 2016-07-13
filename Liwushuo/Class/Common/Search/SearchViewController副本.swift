//
//  SearchViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/2.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 延时弹出键盘(否则弹不出键盘)
        performSelector(#selector(SearchViewController.showKeyBoard), withObject: nil, afterDelay: 0.1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - 视图
    private func setupUI() {
        view.backgroundColor = Color_GlobalBackground
        
        /// 清除左边返回按钮
        let leftBarItem  = UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)))
        navigationItem.leftBarButtonItem = leftBarItem
        
        navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
//        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "快选一份礼物，送给亲爱的Ta吧"
        searchController.searchBar.tintColor = UIColor.whiteColor()
        
        //// 重新设置取消按钮标题
        for (view) in searchController.searchBar.subviews {
            for (subview) in view.subviews {
                if (subview.isKindOfClass(UIButton.self)) {
                    let cancelButton = subview as! UIButton
                    cancelButton.setTitle("取消", forState: .Normal)
                    break
                }
            }
        }
    }
    
    // MARK: - 事件
    @objc private func showKeyBoard() {
        searchController.searchBar.becomeFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchController.searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResultsForSearchController(searchController: UISearchController) {

    }
}
