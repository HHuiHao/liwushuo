//
//  MeTableSectionView.swift
//  Liwushuo
//
//  Created by hans on 16/6/30.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class MeSectionView: UIView {

    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomLineViewLeading: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - 事件
    @IBAction func singleBtnAction(sender: AnyObject) {
        bottomLineViewLeading.constant = 0
    }
    
    @IBAction func strategyBtnAction(sender: AnyObject) {
        bottomLineViewLeading.constant = self.bounds.width * 0.5
    }
}
