//
//  BaseGoodsFeedViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/1.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "BaseGoodsCell"
/// 列数
private let collectionViewRow = 2
/// cell间距
private let cellMargin:CGFloat = 10.0
/// cell里除图片外的固定高度(适配了所有机型在展示的商品图片都为正方形)
private let fixedHeight:CGFloat = 78

class BaseGoodsFeedViewController: BaseViewController {
    
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
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: BaseGoodsFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Color_GlobalBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "BaseGoodsCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        return collectionView
    }()
}

// MARK: - 代理
extension BaseGoodsFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! BaseGoodsCell
        return cell
    }

    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let webViewVC = WebViewController()
        webViewVC.url = "http://s.click.taobao.com/t?e=m%3D2%26s%3D2ZgcWh6O%2BaEcQipKwQzePOeEDrYVVa64XoO8tOebS%2BdRAdhuF14FMa6oLp3eumO7J1gyddu7kN%2BtgmtnxDX9deVMA5qBABUs5mPg1WiM1P5OS0OzHKBZzQIomwaXGXUs78FqzS29vh5nPjZ5WWqolN%2FWWjML5JdM90WyHry0om01pr82yACYuF5aLkF0b2B%2B6zE1jcKGHQ%2BMosMYYBet5g%3D%3D"
        navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (cellMargin * CGFloat(collectionViewRow + 1))) / CGFloat(collectionViewRow)
        let height = width + fixedHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
}

// MARK: - 其他类
class BaseGoodsFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Vertical
    }
}

