//
//  BaseStrategyCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/3.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class BaseStrategyCell: UITableViewCell {

    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var tagTitleBtn: UIButton!
    @IBOutlet weak var headBtn: UIButton!
    @IBOutlet weak var nickLab: UILabel!
    @IBOutlet weak var coverImageview: UIImageView!
    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var priseBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - 视图
    private func setupUI() {
        selectionStyle = UITableViewCellSelectionStyle.None
        layer.borderWidth = 3
        layer.borderColor = Color_GlobalBackground.CGColor
        
        tagBtn.layer.cornerRadius = 5.0
        tagBtn.layer.masksToBounds = true
        headBtn.layer.cornerRadius = headBtn.bounds.width * 0.5
        headBtn.layer.masksToBounds = true
        
        coverImageview.clipsToBounds = true
        coverImageview.contentMode =  UIViewContentMode.ScaleAspectFill;
        coverImageview.image = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
    }
    
    // MARK: - 事件
    @IBAction func tagBtnAction(sender: AnyObject) {
    }
    
    @IBAction func headBtnAction(sender: AnyObject) {
    }
    
    @IBAction func priseBtnAction(sender: AnyObject) {
    }
    
}
