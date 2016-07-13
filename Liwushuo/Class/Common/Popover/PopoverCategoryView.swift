//
//  PopoverCategoryView.swift
//  Liwushuo
//
//  Created by hans on 16/7/7.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

protocol PopoverCategoryViewDelegate: NSObjectProtocol {
    func selectedCategoryEndWithIndex(index: NSInteger)
}


class PopoverCategoryView: UIView {

    weak var delegate: PopoverCategoryViewDelegate?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var switchCover: UIView!
    
    /// 分类标题
    var categoryTitles:[NSString]? {
        didSet {
            /// 滚动的分类视图
            createScrollCategory(categoryTitles!)
            /// 弹出的分类视图
            popoverView = createPopoverView(categoryTitles!)
        }
    }
    /// 弹出分类视图的按钮列数
    let popverBtnColumn = 4
    /// 缓存滚动分类按钮
    var cacheScrollCategoryBtns = [UIButton]()
    /// 缓存格子分类按钮
    var cacheSquareCategoryBtns = [UIButton]()
    /// 当前所选的滚动分类按钮
    var selectedScrollCategoryBtn:UIButton?
    /// 当前所选的格子分类按钮
    var selectedSquareCategoryBtn:UIButton?
    /// 弹出的格子分类视图
    var popoverView:UIView?
    /// 是否显示格子分类视图
    var showingPopoverView = false
    
    class func popoverCategoryView() -> PopoverCategoryView {
        let view =  NSBundle.mainBundle().loadNibNamed("PopoverCategoryView", owner: nil, options: nil).last as! PopoverCategoryView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIFrame()
    }
    
    // MARK: - 视图
    private func setupUI() {
        backgroundColor = UIColor.whiteColor()
        /// 添加滚动红线
        scrollView.addSubview(scrollBottomLineView)
        /// 给蒙版绑定点击事件
        let hideMaskCoverViewPan = UITapGestureRecognizer(target: self, action: #selector(PopoverCategoryView.hidePopoverView))
        maskCoverView.addGestureRecognizer(hideMaskCoverViewPan)
    }
    
    private func setupUIFrame() {
        /// 设置scrollView contentSize
        if let lastCategoryBtn = cacheScrollCategoryBtns.last {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastCategoryBtn.frame), 0)
        }
        /// 设置底部线条frame
        if let categoryBtn = selectedScrollCategoryBtn {
            scrollBottomLineView.center = CGPointMake(categoryBtn.center.x, bounds.height - 2.0)
            scrollBottomLineView.bounds = CGRect(origin: CGPointZero, size: CGSizeMake(categoryBtn.bounds.width - 10.0, 2.0))
        }
    }
    private func createBtn(title: NSString) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13.0)
        btn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), forState: UIControlState.Selected)
        return btn
    }
    
    private func createVerticalLine(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }
    
    private func createHorizontalLine(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }
    
    private func createScrollCategory(titles: [NSString]) {
        for i in 0..<titles.count {
            let title = titles[i]
            let btn = createBtn(title)
            btn.tag = i
            let width:CGFloat = title.boundingRectWithSize(CGSizeZero, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSFontAttributeName : btn.titleLabel!.font], context: nil).width + 20
            let x:CGFloat = cacheScrollCategoryBtns.last == nil ? 5.0 : CGRectGetMaxX(cacheScrollCategoryBtns.last!.frame)
            btn.frame = CGRect(x: x, y: 0, width: width, height: 44.0)
            btn.addTarget(self, action: #selector(PopoverCategoryView.scrollCategoryBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            scrollView.addSubview(btn)
            cacheScrollCategoryBtns.append(btn)
            if i == 0 { scrollCategoryBtnAction(btn)}
        }
    }
    
    private func createPopoverView(titles:[NSString]) -> UIView {
        let btnWidth = ScreenWidth / CGFloat(popverBtnColumn)
        let btnHeight:CGFloat = 50.0
        let popoverView = UIView()
        for i in 0..<titles.count {
            let column = i % popverBtnColumn;
            let row = i / popverBtnColumn
            let x = btnWidth * CGFloat(column)
            let y = btnHeight * CGFloat(row);
            let btn = createBtn(titles[i])
            btn.tag = i
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
            btn.addTarget(self, action: #selector(PopoverCategoryView.squareCategoryBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            popoverView.addSubview(btn)
            cacheSquareCategoryBtns.append(btn)
            /// 线条
            btn.addSubview(createVerticalLine(CGRect(x: btn.bounds.width - 0.5, y: 0, width: 0.5, height: btn.bounds.height)))
            btn.addSubview(createHorizontalLine(CGRect(x: 0, y: btn.bounds.height - 0.5, width: btn.bounds.width, height: 0.5)))
            if i == 0 { squareCategoryBtnAction(btn)}
        }
        popoverView.addSubview(squareBottomLineView)
        popoverView.backgroundColor = UIColor.whiteColor()
        popoverView.frame = CGRectMake(0, -CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame), ScreenWidth, -CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame))
        return popoverView
    }
    
    // MARK: - 公共方法
    /**
     选择分类按钮
     
     - parameter index: 按钮索引
     */
    func scrollCategoryBtnByIndex(index: NSInteger) {
        scrollCategoryBtnAction(cacheScrollCategoryBtns[index])
    }
    
    // MARK: - 事件
    @IBAction func switchBtnAction(sender: UIButton) {
        if !sender.selected {
            showPopoverView()
        } else {
            hidePopoverView()
        }
    }
    
    @objc private func scrollCategoryBtnAction(sender: UIButton) {
        if let btn = selectedScrollCategoryBtn { btn.selected = false }
        sender.selected = !sender.selected
        selectedScrollCategoryBtn = sender
        /// 重设分类标签状态
        if sender.center.x < bounds.width * 0.5 {
            scrollView.setContentOffset(CGPointZero, animated: true)
        } else if scrollView.contentSize.width > bounds.width && sender.center.x > bounds.width * 0.5 && sender.center.x < (scrollView.contentSize.width - bounds.width * 0.5) {
            scrollView.setContentOffset(CGPointMake(sender.frame.origin.x + sender.bounds.width * 0.5 - bounds.width * 0.5, 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPointMake(max(scrollView.contentSize.width - scrollView.bounds.size.width, 0), 0), animated: true)
        }
        /// 重新调用layoutSubviews
        setNeedsLayout()
        delegate?.selectedCategoryEndWithIndex(sender.tag)
    }
    
    @objc private func squareCategoryBtnAction(sender: UIButton) {
        if let btn = selectedSquareCategoryBtn { btn.selected = false }
        sender.selected = !sender.selected
        selectedSquareCategoryBtn = sender
        squareBottomLineView.frame = CGRect(x: sender.frame.origin.x, y: CGRectGetMaxY(sender.frame), width: CGRectGetWidth(sender.frame), height: 2.0)
        if showingPopoverView { hidePopoverView()}
    }
    
    /**
     显示筛选视图
     */
    private func showPopoverView() {
        backgroundColor = switchCover.backgroundColor
        switchBtn.selected = true
        switchCover.hidden = false
        /// 选择格子分类按钮
        squareCategoryBtnAction(cacheSquareCategoryBtns[selectedScrollCategoryBtn!.tag])
        /// 显示蒙版
        showMaskCoverView()
        /// 显示筛选视图
        superview!.insertSubview(popoverView!, belowSubview: self)
        switchCover.alpha = 0
        showingPopoverView = true
        UIView.animateWithDuration(0.3) {
            self.switchCover!.alpha = 1.0
            self.popoverView!.frame.origin.y = self.bounds.height
        }
    }
    
    /**
     隐藏筛选视图
     */
    @objc private func hidePopoverView() {
        guard let _ = popoverView else {
            return
        }
        backgroundColor = UIColor.whiteColor()
        switchBtn.selected = false
        switchCover.hidden = true
        /// 选择格子分类按钮
        scrollCategoryBtnAction(cacheScrollCategoryBtns[selectedSquareCategoryBtn!.tag])
        ///  隐藏筛选视图
        UIView.animateWithDuration(0.3, animations: {
            self.popoverView!.frame.origin.y = -self.popoverView!.bounds.height
            self.switchCover!.alpha = 0.0
        }) { (_) in
            self.popoverView!.removeFromSuperview()
            self.showingPopoverView = false
        }
        /// 隐藏蒙版
        hideMaskCoverView()
    }
    
    /**
     显示蒙版
     */
    private func showMaskCoverView() {
        superview!.insertSubview(maskCoverView, belowSubview: self)
    }
    
    /**
     隐藏蒙版
     */
    @objc private func hideMaskCoverView() {
        maskCoverView.removeFromSuperview()
    }
    
    // MARK: - 懒加载
    private var scrollBottomLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()

    private var squareBottomLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()
    
    private lazy var maskCoverView: MaskCoverView = MaskCoverView()
    
    private lazy var createHLine: UIView = {
        let view = UIView()
        view.backgroundColor = Color_GlobalLine
        return view
    }()
}
