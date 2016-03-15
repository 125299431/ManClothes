//
//  MainTabbarController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height

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
        
        self.tabBar.tintColor = UIColor.init(red: 86/255.0, green: 171/255.0, blue: 228/255.0, alpha: 1)
        
        let homeTabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tabBar_home_nor")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "tabBar_home_sel")?.imageWithRenderingMode(.AlwaysOriginal))
        homeVC.tabBarItem = homeTabBarItem
        
        let issuseTabBarItem = UITabBarItem(title: "专题", image: UIImage(named: "tabBar_issuse_nor")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "tabBar_issuse_sel")?.imageWithRenderingMode(.AlwaysOriginal))
        issuseVC.tabBarItem = issuseTabBarItem
        
        let matchedTabBarItem = UITabBarItem(title: "搭配", image: UIImage(named: "tabBar_match_nor")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "tabBar_match_sel")?.imageWithRenderingMode(.AlwaysOriginal))
        matchedVC.tabBarItem = matchedTabBarItem
        
        let discoverTabBarItem = UITabBarItem(title: "发现", image: UIImage(named: "tabBar_discover_nor")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "tabBar_discover_sel")?.imageWithRenderingMode(.AlwaysOriginal))
        discovedVC.tabBarItem = discoverTabBarItem
        
        let mineTabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tabBar_mine_nor")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "tabBar_mine_sel")?.imageWithRenderingMode(.AlwaysOriginal))
        mineVC.tabBarItem = mineTabBarItem
        
        
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
