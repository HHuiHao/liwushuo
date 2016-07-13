//
//  StrategyViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/9.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellColumns = 2
private let cellMargin:CGFloat = 10.0
private let columnCellHeight:CGFloat = 250.0
private let cellScale:CGFloat = 200.0 / 100.0 /// cellxib宽高比例

private let categoryCellID = "StrategyCategoryCell"
private let columnCellID =  "StrategyColumnCell"
private let sectionID = "StrategySectionView"
class StrategyViewController: BaseViewController {

    private var headerReferenceSize:CGSize?
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
        view.addSubview(collectionView)
    }
    
    private func setupUIFrame() {
        collectionView.frame = view.bounds
    }
    
    // MARK: - 事件
    
    // MARK: - 懒加载
    private lazy var collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: StrategyCollectionFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "StrategyColumnCell", bundle: nil), forCellWithReuseIdentifier: columnCellID)
        collectionView.registerNib(UINib(nibName: "StrategyCategoryCell", bundle: nil), forCellWithReuseIdentifier: categoryCellID)
        collectionView.registerNib(UINib(nibName: "StrategySectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID)
        let section = NSBundle.mainBundle().loadNibNamed("StrategySectionView", owner: self, options: nil).last!
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.headerReferenceSize = CGSize(width: ScreenWidth, height: section.size.height)
        self.headerReferenceSize = collectionViewLayout.headerReferenceSize
        return collectionView
    }()
}

// MARK: - UICollectionView Delegate
extension StrategyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /// 栏目
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(columnCellID, forIndexPath: indexPath) as! StrategyColumnCell
            return cell
        }
        /// 分类
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryCellID, forIndexPath: indexPath) as! StrategyCategoryCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID, forIndexPath: indexPath) as! StrategySectionView
        sectionView.hideMarginTopView(indexPath.section == 0 ? true : false)
        sectionView.viewAllBtn.tag = indexPath.section
        return sectionView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(CommonStrategyViewController(), animated: true)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: columnCellHeight)
        }
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
            return CGSizeMake(headerReferenceSize!.width, headerReferenceSize!.height - 12)
        }
        return headerReferenceSize!
    }
}

// MARK: - 分类
class StrategyCollectionFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Vertical
    }
}

/// 分组头部
class StrategySectionView: UICollectionReusableView {
    
    @IBOutlet weak var marginTopView: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    
    func hideMarginTopView(hide: Bool) {
        marginTopView.hidden = hide
    }
    
    @IBAction func viewAllBtnAction(sender: AnyObject) {
        let tabBarViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabBarController
        let navigationController = tabBarViewController.viewControllers![tabBarViewController.selectedIndex] as! NavigationController
        navigationController.pushViewController(sender.tag == 0 ? AllColumnViewController() : AllClassifyViewController(), animated: true)
    }
}

