//
//  MeFooterView.swift
//  Liwushuo
//
//  Created by hans on 16/6/30.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class MeFooterView: UIView {

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
        addSubview(icon)
        addSubview(tipLab)
        addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(MeFooterView.loginBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    private func setupUIFrame() {
        icon.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self).offset(80)
            make.centerX.equalTo(self.snp_centerX)
        })
        tipLab.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(icon.snp_bottom).offset(10)
            make.centerX.equalTo(self.snp_centerX)
        })
        loginBtn.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    // MARK: - 懒加载
    private var icon: UIImageView = {
        let icon = UIImageView(image: UIImage(named:"me_blank"))
        return icon
    }()
    
    private var tipLab: UILabel = {
        let tipLab = UILabel()
        tipLab.text = "登录以享受更多功能"
        tipLab.textColor = UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        tipLab.font = UIFont.systemFontOfSize(16)
        tipLab.textAlignment = NSTextAlignment.Center
        return tipLab
    }()
    
    private var loginBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.clearColor()
        return btn
    }()
    
    // MARK: - 事件
    @objc private func loginBtnAction(){
        NSNotificationCenter.defaultCenter().postNotificationName(Notif_Login, object: nil)
    }
    
}
