//
//  ColumnListHeader.swift
//  Liwushuo
//
//  Created by hans on 16/7/12.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class ColumnListHeader: UIView {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.clipsToBounds = true
        photoImageView.contentMode =  UIViewContentMode.ScaleAspectFill;
        photoImageView.image = UIImage(named: "strategy_\(Int(arc4random() % 17) + 1).jpg")
    }
    
    class func columnListHeader() -> ColumnListHeader{
        return NSBundle.mainBundle().loadNibNamed("ColumnListHeader", owner: nil, options: nil).last as! ColumnListHeader
    }

}
