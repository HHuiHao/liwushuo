//
//  SearchViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/2.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let SearchGiftCellReuseIdentifier = "SearchGiftCell"
class SearchViewController: BaseViewController {
    
    struct Static {
        static var dispatchOnceToken: dispatch_once_t = 0
    }
    private var tableView: UITableView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addNotif()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /// 延时弹出键盘(否则键盘弹不出)
        dispatch_once(&Static.dispatchOnceToken) {
            self.performSelector(#selector(SearchViewController.searchBarBecomeFirstResponder), withObject: nil, afterDelay: 0.1)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarResignFirstResponder()
        removeNotif()
        popoverSortView.hide()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addNotif()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBarResignFirstResponder()
    }
    
    private func addNotif() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.tagBtnAction(_:)), name: Notif_BtnAction_SearchTag, object: nil)
    }
    
    private func removeNotif() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Notif_BtnAction_SearchTag, object: nil)
    }
    
    // MARK: - 视图
    private func setupUI() {
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        view.addSubview(tableView!)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = Color_GlobalBackground
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView?.sectionFooterHeight = 0.0001
        tableView?.sectionHeaderHeight = 0.0001
        tableView?.registerNib(UINib(nibName: "SearchGiftCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: SearchGiftCellReuseIdentifier)
        tableView?.tableHeaderView = searchHeaderView
        /// 刷选视图
        view.addSubview(popoverSortView)
    }

    private func resetBarBtnSate() {
        if searchBar.isFirstResponder() {
            /// 弹出键盘
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
            rightBtn.setImage(UIImage(named: ""), forState: UIControlState.Normal)
            rightBtn.setTitle("取消", forState: UIControlState.Normal)
        } else {
            /// 隐藏键盘
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
            rightBtn.setImage(UIImage(named: "icon_sort"), forState: UIControlState.Normal)
            rightBtn.setTitle("", forState: UIControlState.Normal)
        }
    }

    // MARK: - 事件
    @objc private func searchBarBecomeFirstResponder() {
        searchBar.becomeFirstResponder()
        resetBarBtnSate()
    }
    
    @objc private func searchBarResignFirstResponder() {
        searchBar.resignFirstResponder()
        resetBarBtnSate()
    }
    
    @objc private func leftBtnAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func rightBtnAction() {
        if searchBar.isFirstResponder() {
            searchBarResignFirstResponder()
        } else {
            /// 弹出刷选视图
            if popoverSortView.hidden {
                popoverSortView.show()
            } else {
                popoverSortView.hide()
            }
        }
    }
    
    // MARK: - 通知
    @objc private func tagBtnAction(btn: AnyObject){
        searchBarResignFirstResponder()
        let searchResult = SearchResultViewController()
        navigationController?.pushViewController(searchResult, animated: true)
    }
    
    // MARK: - 懒加载
    private lazy var searchBar: UISearchBar = UISearchBar(searchGifdelegate: self, backgroundColor:UIColor.whiteColor(), backgroundImage: UINavigationBar.appearance().backgroundImageForBarMetrics(UIBarMetrics.Default)!)
    
    private lazy var leftBtn: UIButton = UIButton(backTarget: self, action: #selector(SearchViewController.leftBtnAction))
    
    private lazy var rightBtn: UIButton = UIButton(cancelTarget: self, action: #selector(SearchViewController.rightBtnAction))
    
    private lazy var searchHeaderView: SearchHeaderView = {
        let view = SearchHeaderView { [unowned self] (height) in
            self.searchHeaderView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: height)
            self.tableView?.tableHeaderView = self.searchHeaderView
        }
        return view
    }()
    
    private lazy var popoverSortView = PopoverSortView(frame: CGRect(x: ScreenWidth - 155, y: 0, width: 155, height: 190))
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBarBecomeFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBarResignFirstResponder()
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SearchGiftCellReuseIdentifier)
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchBarResignFirstResponder()
        navigationController?.pushViewController(SearchGifViewController(), animated: true)
    }
}

