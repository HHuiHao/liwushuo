//
//  AllColumnViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/12.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellColumns = 1
private let cellMargin:CGFloat = 10.0
/// cellxib宽高比例
private let cellScale:CGFloat = 340.0 / 90.0
private let cellID = "StrategyColumnCellCell"
class AllColumnViewController: BaseViewController {

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
        view.addSubview(collectionView)
    }
    
    private func setupUIFrame() {
        collectionView.frame = view.bounds
    }
    
    // MARK: - 懒加载
    private lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: AllColumnViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerNib(UINib(nibName: "StrategyColumnCellCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
}

// MARK: - 代理
extension AllColumnViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! StrategyColumnCellCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        navigationController?.pushViewController(ColumnListViewController(), animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.bounds.width - (CGFloat(cellColumns + 1) * cellMargin)
        let height = width / cellScale
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    
}


// MARK: - 其他类
class AllColumnViewFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Vertical
    }
}
