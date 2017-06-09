//
//  BaseViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var bgImage = UIImage(named: "Home_background.png")
        //拉伸图片
        UIGraphicsBeginImageContext(CGSize(width: kScreenWidth, height: kScreenHeight))
        bgImage?.draw(in: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor.init(patternImage: bgImage!)

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
