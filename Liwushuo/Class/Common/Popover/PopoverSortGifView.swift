//
//  PopoverSortGifView.swift
//  Liwushuo
//
//  Created by hans on 16/7/6.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

let btnColumn = 3
let btnMargin:CGFloat = 15.0
let btnWidth:CGFloat = (ScreenWidth - CGFloat((btnColumn + 1)) * btnMargin) / CGFloat(btnColumn)
let btnHeight:CGFloat = 44.0

class PopoverSortGifView: UIView {

    @IBOutlet weak var subjectBtn: UIButton!
    @IBOutlet weak var characterBtn: UIButton!
    @IBOutlet weak var occasionBtn: UIButton!
    @IBOutlet weak var priceBtn: UIButton!
    
    var currPopCoverView:UIView?
    var popoCoverDict = [String: UIView]()
    var showingPopoCover = false
    var currPopBtn:UIButton?
    var cacheSelectTagBtn = [String: UIButton]()
    
    class func popoverSortGifView() -> PopoverSortGifView {
        return NSBundle.mainBundle().loadNibNamed("PopoverSortGifView", owner: nil, options: nil).last as! PopoverSortGifView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - 视图
    private func setupUI() {
        /// 记录当前选项
        subjectBtn.tag = 0
        characterBtn.tag = 1
        occasionBtn.tag = 2
        priceBtn.tag = 3
       /// 给蒙版绑定点击事件
       let hideMaskCoverViewPan = UITapGestureRecognizer(target: self, action: #selector(PopoverSortGifView.hidePopoverView))
        maskCoverView.addGestureRecognizer(hideMaskCoverViewPan)
        /// 创建筛选视图
        let allTitles = [["全部", "男票", "女盆友", "闺蜜们", "基友", "爸爸妈妈", "小盆友", "同事"], ["全部", "生日", "情人节", "结婚", "新年", "感谢", "纪念日", "乔迁", "圣诞节"], ["全部", "萌", "小清新", "创意", "奇葩", "文艺范", "科技感", "设计感"], ["全部", "50以下", "50-200", "200-500", "500-1000", "1000以上"]]
        for i in 0 ..< allTitles.count {
            let popView = createPopoverView(i, titles: allTitles[i])
            popoCoverDict["\(i)"] = popView
        }
    }
    
    /**
     创建筛选视图
     
     - parameter section: 记录当选项组
     - parameter titles:  选项组内所有标签的标题
     
     - returns: 返回筛选视图
     */
    private func createPopoverView(section:NSInteger, titles: NSArray) -> UIView {
        let moveViewHeight:CGFloat = 30.0
        var popoverViewHeight:CGFloat = 0
        let popoverView = UIView()
        popoverView.backgroundColor = Color_GlobalBackground
        /// 添加标签按钮
        for i in 0 ..< titles.count {
            let column = i % btnColumn;
            let row = i / btnColumn
            let x = (btnWidth + btnMargin) * CGFloat(column) + btnMargin
            let y = (btnHeight + btnMargin) * CGFloat(row) + btnMargin;
            let btn = createBtn(section, row: i, title: titles[i] as! NSString)
            popoverView.addSubview(btn)
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
            popoverViewHeight = CGRectGetMaxY(btn.frame) + btnMargin
        }
        popoverView.frame = CGRectMake(0, -popoverViewHeight, ScreenWidth, popoverViewHeight + moveViewHeight)
        /// 添加底部拖拽视图
        let moveView = UIView()
        moveView.frame = CGRect(x: 0, y: CGRectGetHeight(popoverView.frame) - moveViewHeight, width: popoverView.bounds.width, height: moveViewHeight)
        moveView.backgroundColor = UIColor.whiteColor()
        popoverView.addSubview(moveView)
        let line = UIView()
        line.frame = CGRectMake(0, 0, moveView.bounds.width, 0.5)
        line.backgroundColor = UIColor (red: 223.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        moveView.addSubview(line)
        let moveImageView = UIImageView(image: UIImage(named: "giftcategorydetail_icon_fixed"))
        moveImageView.frame.origin.x = (CGRectGetWidth(moveView.frame) -
            moveImageView.image!.size.width) * 0.5
        moveImageView.frame.origin.y = (CGRectGetHeight(moveView.frame) -
            moveImageView.image!.size.height) * 0.5
        moveView.addSubview(moveImageView)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(PopoverSortGifView.viewDragged(_:)))
        popoverView.addGestureRecognizer(gesture)
        popoverView.userInteractionEnabled = true
        
        return popoverView
    }
    
    /**
     创建标签按钮
     */
    private func createBtn(section: NSInteger, row: NSInteger, title: NSString) -> UIButton {
        let btn = UIButton(srotTagTarget: self, action: #selector(PopoverSortGifView.tagBtnAction(_:)))
        btn.tag = section
        btn.setTitle(title as String, forState: UIControlState.Normal)
        if row == 0 {
            /// 缓存当前所选的按钮
            btn.selected = true
            cacheSelectTagBtn["\(btn.tag)"] = btn
        } else {
            btn.selected = false
        }
        return btn
    }
    
    // MARK: - 事件
    @IBAction func subjectBtnAction(sender: UIButton) {
        showPopoverView(sender)
    }
    
    @IBAction func occasionBtnAction(sender: UIButton) {
        showPopoverView(sender)
    }
    
    @IBAction func characterBtnAction(sender: UIButton) {
        showPopoverView(sender)
    }
    
    @IBAction func priceBtnAction(sender: UIButton) {
        showPopoverView(sender)
    }
    
    @objc func viewDragged(gestureRecognizer: UIPanGestureRecognizer) {
        /// 从缓存取出当前按钮下的筛选视图
        let popCover = popoCoverDict["\(currPopBtn!.tag)"]
        let maxCenterY = popCover!.frame.height * 0.5 + bounds.height
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            if gestureRecognizer.view!.center.y > maxCenterY {
                return
            }
            let translation = gestureRecognizer.translationInView(self)
            if(gestureRecognizer.view!.center.y < maxCenterY) {
                gestureRecognizer.view!.center = CGPointMake(gestureRecognizer.view!.center.x, gestureRecognizer.view!.center.y + translation.y)
            }else {
                gestureRecognizer.view!.center = CGPointMake(gestureRecognizer.view!.center.x, maxCenterY - 0.001)
            }
            gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self)
        }
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if(gestureRecognizer.view!.center.y < maxCenterY * 0.5) {
                hidePopoverView()
            } else {
                 gestureRecognizer.view!.center = CGPointMake(gestureRecognizer.view!.center.x, maxCenterY)
                gestureRecognizer.setTranslation(CGPointMake(0,0), inView: self)
            }
        }
        
    }
    
    /**
     标签按钮
     */
    @objc private func tagBtnAction(btn: UIButton) {
        
        print(btn.titleLabel?.text)
        if let cacheBtn = cacheSelectTagBtn["\(btn.tag)"] {
            cacheBtn.selected = false
        }
        btn.selected = true
        cacheSelectTagBtn["\(btn.tag)"] = btn
    }
    
    /**
     显示筛选视图
     */
    private func showPopoverView(sender: UIButton) {
        sender.selected = !sender.selected
        /// 重复点击按钮
        if currPopBtn == sender {
            hidePopoverView()
            return
        }
        /// 更改上一个按钮状态
        if let btn = currPopBtn {
            btn.selected = !btn.selected
        }
        /// 保存当前按钮
        currPopBtn = sender
        /// 从缓存取出当前按钮下的筛选视图
        let popCover = popoCoverDict["\(sender.tag)"]
        /// 判断筛选视图是否存在
        guard let view = popCover else {
            return
        }
        /// 显示蒙版
        showMaskCoverView(view)
        /// 显示筛选视图
        superview!.insertSubview(view, belowSubview: self)
        if showingPopoCover {
            /// 快速切换显示
            currPopCoverView!.removeFromSuperview()
            view.frame.origin.y = self.bounds.height
        } else {
            /// 动画显示
            showingPopoCover = true
            UIView.animateWithDuration(0.3) {
                view.frame.origin.y = self.bounds.height
            }
        }
        currPopCoverView = view
        
    }
    
    /**
     隐藏筛选视图
     */
    @objc private func hidePopoverView() {
        /// 隐藏当前筛选视图
        guard let view = currPopCoverView else {
            return
        }
        /// 重置状态
        showingPopoCover = false
        currPopBtn = nil
        /// 动画隐藏
        UIView.animateWithDuration(0.3, animations: {
                view.frame.origin.y = -view.bounds.height
            }) { (_) in
                view.removeFromSuperview()
        }
        /// 隐藏蒙版
        hideMaskCoverView()
    }
    
    /**
     显示蒙版
     */
    private func showMaskCoverView(belowSubview: UIView) {
        superview!.insertSubview(maskCoverView, belowSubview: self)
    }
    
    /**
     隐藏蒙版
     */
    @objc private func hideMaskCoverView() {
        maskCoverView.removeFromSuperview()
    }
    
    // MARK: - 懒加载
    private lazy var maskCoverView: MaskCoverView = MaskCoverView()
}
