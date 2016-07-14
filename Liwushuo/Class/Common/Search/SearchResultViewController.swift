//
//  SearchResultViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/4.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var redLineView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var redLineViewConstraintLeading: NSLayoutConstraint!
    
    override func loadView() {
        let classString = String(self.dynamicType)
        NSBundle.mainBundle().loadNibNamed(classString, owner: self, options: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        popoverSortView.hide()
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
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        addChildViewController(goodsVC)
        addChildViewController(strategyVC)
        scrollView.addSubview(goodsVC.view)
        scrollView.addSubview(strategyVC.view)
        view.addSubview(popoverSortView)
    }
    
    private func setupUIFrame() {
        goodsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height:scrollView.bounds.height)
        strategyVC.view.frame = CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height:scrollView.bounds.height)
        scrollView.contentSize = CGSizeMake(scrollView.bounds.width * 2, 0)
    }
    
    // MARK: - 事件
    @IBAction func singleBtnAction(sender: AnyObject) {
        resetRedlineView(true)
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    @IBAction func strategyBtnAction(sender: AnyObject) {
        resetRedlineView(false)
        self.scrollView.setContentOffset(CGPointMake(self.scrollView.bounds.width, 0), animated: true)
    }
    
    func resetRedlineView(scrollToleft: Bool) {
        redLineViewConstraintLeading.constant = scrollToleft ? 0 : self.topView.bounds.width * 0.5
    }
    
    @objc private func leftBtnAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func rightBtnAction() {
        /// 弹出刷选视图
        if popoverSortView.hidden {
            popoverSortView.show()
        } else {
            popoverSortView.hide()
        }
    }
    
    // MARK: - 懒加载
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "快选一份礼物，送给亲爱的Ta吧"
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.backgroundImage = UINavigationBar.appearance().backgroundImageForBarMetrics(UIBarMetrics.Default)
        return searchBar
    }()
    
    private lazy var goodsVC:CommonGoodsFeedViewController = CommonGoodsFeedViewController()
    
    private lazy var strategyVC:CommonStrategyViewController = CommonStrategyViewController()
    
    private lazy var leftBtn: UIButton = UIButton(backTarget: self, action: #selector(SearchResultViewController.leftBtnAction))
    
    private lazy var rightBtn: UIButton = UIButton(sortTarget: self, action: #selector(SearchResultViewController.rightBtnAction))
    
    private lazy var popoverSortView = PopoverSortView(frame: CGRect(x: ScreenWidth - 155, y: 0, width: 155, height: 190))
}

// MARK: - 代理
extension SearchResultViewController:UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        resetRedlineView(scrollView.contentOffset.x == 0.0 ? true : false)
    }
}

extension SearchResultViewController:UISearchBarDelegate {
    
}
