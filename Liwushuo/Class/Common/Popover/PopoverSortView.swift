//
//  PopoverSortView.swift
//  Liwushuo
//
//  Created by hans on 16/7/5.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "PopoverSortCell"
class PopoverSortView: UIView {

    private var cacheFrame:CGRect?
    private var tableView:UITableView?
    private var markSelectCellRow = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIFrame()
    }
    
    // MARK: - 视图
    private func setupUI() {
        hidden = true
        addSubview(bgImageView)
        
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.sectionFooterHeight = 0.0001
        tableView!.sectionHeaderHeight = 0.0001
        tableView!.backgroundView = nil
        tableView!.backgroundColor = UIColor.clearColor()
        tableView!.separatorInset = UIEdgeInsetsZero
        tableView!.layoutMargins = UIEdgeInsetsZero
        tableView!.separatorColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        tableView!.registerNib(UINib(nibName: "PopoverSortCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellReuseIdentifier)
        tableView!.tableFooterView = UIView()
        addSubview(tableView!)
    }
    
    private func setupUIFrame() {
        bgImageView.frame = bounds
        tableView?.frame = CGRectMake(0, 10, bounds.width, bounds.height - 14)
    }
    
    func show(){
        // 更改anchorPoint后，position(frame)会改变
        let oldposition = layer.position
        let oldanchorPoint = layer.anchorPoint
        let newanchorPoint = CGPoint(x: 0.5, y: 0.0)
        let newpositionX = oldposition.x + (newanchorPoint.x - oldanchorPoint.x)  * bounds.size.width
        let newpositionY = oldposition.y + (newanchorPoint.y - oldanchorPoint.y)  * bounds.size.height
        hidden = false
        transform = CGAffineTransformMakeScale(1.0, 0.0)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        layer.position = CGPoint(x: newpositionX, y: newpositionY)
        UIView.animateWithDuration(0.2, animations: {
            self.transform = CGAffineTransformIdentity
        })
    }
    
    func hide() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(1.0, 0.0000001)
            }, completion: { (_) -> Void in
               self.hidden = true
        })
     }
    
    // MARK: - 懒加载
    private lazy var datas:NSArray = ["默认排序", "按热度排序", "价格从低到高", "价格从高到低"]
    
    private lazy var bgImageView:UIImageView = UIImageView(image: UIImage(named: "popover_background_right"))
}

// MARK: - 代理
extension PopoverSortView:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! PopoverSortCell
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false
        cell.textLab.text = datas[indexPath.row] as? String
        cell.selectBtn.hidden = indexPath.row == markSelectCellRow ? false : true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        markSelectCellRow = indexPath.row
        tableView.reloadData()
    }
}

