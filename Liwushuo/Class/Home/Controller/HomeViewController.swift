//
//  HomeViewController.swift
//  Liwushuo
//
//  Created by hans on 16/6/28.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var categoryTitles: [NSString]
    {
        return ["精选", "海淘", "创意生活", "送女票", "科技范", "送爸妈", "送基友", "送闺蜜", "送同事", "送宝贝", "设计感", "文艺范", "奇葩搞怪", "萌萌哒"]
    }
    var cacheCategoryViews = [UIView]()
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(gifTarget: self, action: #selector(HomeViewController.gifBtnAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(searchTarget: self, action: #selector(HomeViewController.searchBtnAction))
        navigationItem.titleView = titleImageView
        view.addSubview(scrollView)
        view.addSubview(popoverCategoryView)
        
        for i in 0..<categoryTitles.count {
            let categoryVC = i == 0 ? ChoiceStrategyViewController() : CommonStrategyViewController()
            addChildViewController(categoryVC)
            scrollView.addSubview(categoryVC.view)
            cacheCategoryViews.append(categoryVC.view)
        }
    }
    
    private func setupUIFrame() {
        popoverCategoryView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44.0)
        scrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(popoverCategoryView.frame), width: view.bounds.width, height: view.bounds.height - popoverCategoryView.bounds.height - 44.0)
        for i in 0..<cacheCategoryViews.count {
            let view = cacheCategoryViews[i]
            view.frame = CGRect(x: scrollView.bounds.width * CGFloat(i), y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        }
        scrollView.contentSize = CGSizeMake(CGFloat(cacheCategoryViews.count) * scrollView.bounds.width, 0)
    }

    // MARK: - 事件
    @objc private func searchBtnAction() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    @objc private func gifBtnAction() {
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
        
    }
    
    // MARK: - 懒加载
    private lazy var titleImageView:UIImageView = {
        let image = UIImage(named: "logo")
        let titleImageView = UIImageView(image: image)
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        titleImageView.bounds = CGRectMake(0, 0, 20.0 * (image!.size.width / image!.size.height), 20.0)
        return titleImageView
    }()
    
    private lazy var popoverCategoryView: PopoverCategoryView = {
       let view =  PopoverCategoryView.popoverCategoryView()
        view.delegate = self
        view.categoryTitles = self.categoryTitles
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.pagingEnabled = true
        return view
    }()
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.bounds.width;
        popoverCategoryView.scrollCategoryBtnByIndex(NSInteger(index))
    }
}

extension HomeViewController: PopoverCategoryViewDelegate {
    
    func selectedCategoryEndWithIndex(index: NSInteger) {
        scrollView.setContentOffset(CGPointMake(CGFloat(index) * scrollView.bounds.width, 0), animated: true)
    }
}
