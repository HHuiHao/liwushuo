//
//  TopicCollectionView.swift
//  Liwushuo
//
//  Created by hans on 16/7/8.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "TopicCell"
private let cellMargin:CGFloat = 10.0
class TopicCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 视图
    private func setupUI() {
        backgroundColor = UIColor.whiteColor()
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        pagingEnabled = false
        delegate = self;
        dataSource = self;
        registerNib(UINib(nibName: "TopicCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }

}

// MARK: - 代理
extension TopicCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(cellMargin, cellMargin, cellMargin, cellMargin);
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let tabBarViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabBarController
        let navigationController = tabBarViewController.viewControllers![tabBarViewController.selectedIndex] as! NavigationController
        navigationController.pushViewController(CommonStrategyViewController(), animated: true)
    }
    
}


// MARK: - 其他类
class TopicCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.clipsToBounds = true
        photoImageView.contentMode =  UIViewContentMode.ScaleAspectFill;
        photoImageView.image = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
    }
}

class TopicFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        minimumInteritemSpacing = cellMargin * 0.5
        minimumLineSpacing = cellMargin
        scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
}