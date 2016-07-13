//
//  LoginViewController.swift
//  Liwushuo
//
//  Created by hans on 16/6/30.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var getVerifycodeBtn: UIButton!
    @IBOutlet weak var passIconBtn: UIButton!
    @IBOutlet weak var changeLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - 视图
    private func setupUI(){
        getVerifycodeBtn.hidden = true
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        getVerifycodeBtn.layer.cornerRadius = 5
        getVerifycodeBtn.layer.masksToBounds = true
    }
    
    // MARK: - 事件
    @IBAction func closeAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getVerifycodeBtnAction(sender: AnyObject) {
        print("获取验证码")
    }
    
    @IBAction func changePassBtnAction(sender: AnyObject) {
        passIconBtn.selected = !passIconBtn.selected
        getVerifycodeBtn.hidden = !passIconBtn.selected
        if passIconBtn.selected {
            passTextField.placeholder = "短信验证码"
            changeLoginBtn.setTitle("使用密码登录", forState: UIControlState.Normal)
        } else {
            passTextField.placeholder = "输入密码"
            changeLoginBtn.setTitle("使用验证码登录", forState: UIControlState.Normal)
        }
    }

    @IBAction func loginBtnAction(sender: AnyObject) {
        print("登录")
    }
    
    @IBAction func weiboBtnAction(sender: AnyObject) {
        print("微博登录")
    }
    
    @IBAction func weixinBtnAction(sender: AnyObject) {
        print("微信登录")
    }
    
    @IBAction func qqBtnAction(sender: AnyObject) {
        print("QQ登录")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}
