//
//  ClassifyViewController.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class ClassifyViewController: BaseViewController {
    
    struct Static {
        static var dispatchOnceToken: dispatch_once_t = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
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
        view.backgroundColor = Color_GlobalBackground
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(chooseGifTarget: self, action: #selector(ClassifyViewController.SearchGifBtnAction))
        navigationItem.rightBarButtonItem?.customView?.alpha = 0
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        scrollView.addSubview(strategyVC.view)
        scrollView.addSubview(singleGifVC.view)
        addChildViewController(strategyVC)
        addChildViewController(singleGifVC)
    }

    private func setupUIFrame() {
        dispatch_once(&Static.dispatchOnceToken) {
            self.titleView.frame = CGRectMake(0, 0, 120.0, 44.0)
            self.searchBar.frame = CGRectMake(0, 0, self.view.bounds.width, 44.0)
            self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.view.bounds.width, self.view.bounds.height - self.searchBar.bounds.height - 44.0)
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.width * 2.0, self.scrollView.bounds.height)
            self.strategyVC.view.frame = self.scrollView.bounds
            self.singleGifVC.view.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame), 0, self.scrollView.bounds.width, self.scrollView.bounds.height)
        }
    }
    
    // MARK: - 事件
    @objc private func SearchGifBtnAction() {
        navigationController?.pushViewController(SearchGifViewController(), animated: true)
    }
    
    // MARK: - 懒加载
    private lazy var titleView: ClassifyTitleView = {
       let view = ClassifyTitleView()
        view.delegate = self
        return view
    }()

    private lazy var searchBar: UISearchBar =  UISearchBar(searchGifdelegate: self, backgroundColor:UIColor(white: 0, alpha: 0.05), backgroundImage:UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeZero))

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.pagingEnabled = true
        return view
    }()
    
    private lazy var strategyVC: StrategyViewController = StrategyViewController()
    private lazy var singleGifVC: SingleGifViewController = SingleGifViewController()
}

// MARK: - 代理
extension ClassifyViewController: ClassifyTitleViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    
    // MARK: - ClassifyTitleViewDelegate
    func selectedOptionAtIndex(index: NSInteger) {
        scrollView.setContentOffset(CGPointMake(CGFloat(index) * scrollView.bounds.width, 0), animated: true)
    }

    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /// 更改选礼神器按钮alpha
        navigationItem.rightBarButtonItem?.customView?.alpha = scrollView.contentOffset.x / scrollView.bounds.width
        /// 更改titleView底部线条x
        titleView.scrollLine(scrollView.bounds.width, offsetX: scrollView.contentOffset.x)
    }
}
