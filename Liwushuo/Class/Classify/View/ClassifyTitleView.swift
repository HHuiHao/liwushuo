//
//  ClassifyTitleView.swift
//  Liwushuo
//
//  Created by hans on 16/7/9.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

protocol ClassifyTitleViewDelegate: NSObjectProtocol {
    func selectedOptionAtIndex(index: NSInteger)
}

class ClassifyTitleView: UIView {

    weak var delegate: ClassifyTitleViewDelegate?
    private var singleBtn:UIButton?
    private var strategyBtn:UIButton?
    private let lineMargin:CGFloat = 10.0
    
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
        backgroundColor = UIColor.clearColor()
        strategyBtn = createBtn("攻略")
        strategyBtn?.addTarget(self, action: #selector(ClassifyTitleView.strategyBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        singleBtn = createBtn("单品")
        singleBtn?.addTarget(self, action: #selector(ClassifyTitleView.singleBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(strategyBtn!)
        addSubview(singleBtn!)
        addSubview(line)
    }
    
    private func setupUIFrame() {
        strategyBtn?.frame = CGRectMake(0, 0, frame.size.width * 0.5, frame.size.height)
        singleBtn?.frame = CGRectMake(CGRectGetMaxX(strategyBtn!.frame), 0, frame.size.width * 0.5, frame.size.height)
        line.frame = CGRectMake(lineMargin * 0.5, frame.size.height - 6.0, frame.size.width * 0.5 - lineMargin, 2.0)
    }
    
    private func createBtn(titile: NSString) -> UIButton {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle(titile as String, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return btn
    }
    
    // MARK: - 事件
    @objc private func strategyBtnAction() {
        delegate?.selectedOptionAtIndex(0)
    }
    
    @objc private func singleBtnAction() {
        delegate?.selectedOptionAtIndex(1)
    }
    
    // MARK: - 懒加载
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    // MARK: - 公共方法
    func scrollLine(scrollViewWidth: CGFloat, offsetX: CGFloat) {
        line.frame.origin.x = lineMargin * 0.5 + offsetX / scrollViewWidth * (bounds.width - line.bounds.width - lineMargin)
    }
}
