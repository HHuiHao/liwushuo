//
//  StrategyColumnCellCell.swift
//  Liwushuo
//
//  Created by hans on 16/7/10.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class StrategyColumnCellCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var viewAllcoverView: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.clipsToBounds = true
        photoImageView.contentMode =  UIViewContentMode.ScaleAspectFill;
        photoImageView.image = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
        
        viewAllBtn.layer.masksToBounds = true
        viewAllBtn.layer.cornerRadius = 2.0
        viewAllBtn.layer.borderColor = viewAllBtn.titleLabel!.textColor.CGColor
        viewAllBtn.layer.borderWidth = 0.5
        
    }
    
    @IBAction func viewAllBtnAction(sender: AnyObject) {
    }
    
}
