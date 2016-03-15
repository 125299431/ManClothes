//
//  MainTabbarController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._initViewController()

    }
    
    func _initViewController() {
        let homeVC = HomeViewController()
        let issuseVC = IssuseViewController()
        let matchedVC = MatchedViewController()
        let discovedVC = DiscoverViewController()
        let mineVC = MineViewController()
        
        let vcArr = [homeVC, issuseVC, matchedVC, discovedVC, mineVC]
        
        var navArr:[BaseNavigationController] = []
        
        for index in 0...vcArr.count - 1 {
            let vc = vcArr[index]
            let nav = BaseNavigationController(rootViewController: vc)
            navArr.append(nav)
        }
        
        self.viewControllers = navArr
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
