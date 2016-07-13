//
//  MeOptionView.swift
//  Liwushuo
//
//  Created by hans on 16/6/30.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class MeOptionView: UIView {

    var btns = [UIButton]()
    
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
    private func setupUI(){
        backgroundColor = UIColor.whiteColor()
        addSubview(createBtn("shopcart_bt", title: "购物车"))
        addSubview(createBtn("order_bt", title: "订单"))
        addSubview(createBtn("discount_bt", title: "礼劵"))
        addSubview(createBtn("costomer_bt", title: "客服"))
        addSubview(line)
    }

    private func setupUIFrame() {
        var i = 0
        let width = frame.width / 4
        let height = frame.height
        for btn in btns {
            btn.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            btn.tag = i
            i += 1
        }
        line.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(0.5)
        }
    }
    
    private func createBtn(imageName: NSString, title: NSString) -> UIButton{
        let btn = ButtonTitleDown()
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(12)
        btn.setImage(UIImage(named: imageName as String), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(MeOptionView.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btns.append(btn)
        
        return btn
    }
    
    // MARK: - 懒加载
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 208.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        return line
    }()

    
    // MARK: - 事件
    @objc private func buttonAction(button: UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
}
