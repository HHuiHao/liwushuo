//
//  Refresh.swift
//  Liwushuo
//
//  Created by hans on 16/7/2.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit
import MJRefresh

class Refresh: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        
        var idleImages = [UIImage]()
        var pullingImages = [UIImage]()
        var refreshingImages = [UIImage]()
        
        for i in 0...10 {
            idleImages.append(UIImage(named: String(format: "loading_dragdown_%02d", i))!.resetImageSize(100))
        }
        pullingImages.append(UIImage(named: "loading_00")!.resetImageSize(100))
        for i in 0...22 {
            refreshingImages.append(UIImage(named: String(format: "loading_%02d", i))!.resetImageSize(100))
        }
        lastUpdatedTimeLabel.hidden = true
        stateLabel.hidden = true
        setImages(idleImages, forState: MJRefreshState.Idle)
        setImages(pullingImages, forState: MJRefreshState.Pulling)
        setImages(refreshingImages, forState: MJRefreshState.Refreshing)
    }
}
