//
//  CommonFetureViewController.swift
//  Liwushuo
//
//  Created by hans on 16/7/13.
//  Copyright © 2016年 汉斯哈哈哈. All rights reserved.
//

import UIKit

class CommonFetureViewController: UIViewController {

    override func loadView() {
        let classString = String(self.dynamicType)
        NSBundle.mainBundle().loadNibNamed(classString, owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
