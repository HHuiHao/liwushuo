//
//  SingleGifViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/9.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellColumns = 3
private let cellMargin:CGFloat = 10.0
private let cellScale:CGFloat = 100.0 / 140.0 /// cellxib宽高比例
private let cellID = "SingleGifCell"
private let sectionID = "SingleGifSectionView"
private let columnCellID = "columnCell"
class SingleGifViewController: BaseViewController {

    private var headerReferenceSize:CGSize?
    private var selectedColumnRow = 0
    /// ture: 点击栏目 false: 滚动collectionView
    private var isSelectedColumn = false
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
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
    
    private func setupUIFrame() {
        let scale:CGFloat = 0.25
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width * scale, height: view.bounds.height)
        collectionView.frame = CGRect(x: CGRectGetMaxX(tableView.frame), y: 0, width: view.bounds.width * (1 - scale) , height: view.bounds.height)
        
    }
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: StrategyCollectionFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "SingleGifCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.registerNib(UINib(nibName: "SingleGifSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID)
        let section = NSBundle.mainBundle().loadNibNamed("SingleGifSectionView", owner: self, options: nil).last!
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.headerReferenceSize = CGSize(width: ScreenWidth, height: section.size.height)
        self.headerReferenceSize = collectionViewLayout.headerReferenceSize
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color_GlobalBackground
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionFooterHeight = 0.0001
        tableView.sectionHeaderHeight = 0.0001
        tableView.registerNib(UINib(nibName: "SingleGifColumnCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: columnCellID)
        return tableView
    }()
}

// MARK: - 代理
extension SingleGifViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 18
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SingleGifCell
        /// 滚动栏目列表
        if !isSelectedColumn && selectedColumnRow != indexPath.section {
            selectedColumnRow = indexPath.section
            tableView.reloadData()
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: indexPath.section, inSection: 0), atScrollPosition: .Top, animated: true)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID, forIndexPath: indexPath) as! SingleGifSectionView
        return sectionView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(CommonGoodsFeedViewController(), animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (cellMargin * CGFloat(cellColumns + 1))) / CGFloat(cellColumns)
        let height = width / cellScale
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, cellMargin, 0, cellMargin);
        }
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        }
        return headerReferenceSize!
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isSelectedColumn = !scrollView.isKindOfClass(UICollectionView)
    }
}

extension SingleGifViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(columnCellID) as! SingleGifColumnCell
        cell.changeStatus(indexPath.row == selectedColumnRow ? true : false)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        isSelectedColumn = true
        selectedColumnRow = indexPath.row
        tableView.reloadData()
        /// 滚动商品列表
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: indexPath.row), atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
    }
    
}

// MARK: - 其他类
class SingleGifCollectionFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Vertical
    }
}

/// 分组头部
class SingleGifSectionView: UICollectionReusableView {

}