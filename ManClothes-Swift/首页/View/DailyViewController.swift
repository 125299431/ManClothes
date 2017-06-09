//
//  DailyViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/29.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DailyViewController: BaseViewController {

    var buttonImageData:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "洗护专区"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.blue]
        
        self._initView()
        self._loadData()
        
    }
    
    func _initView() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftBtn.setImage(UIImage(named: "backButton_blue.png"), for: UIControlState())
        leftBtn.addTarget(self, action: #selector(DailyViewController.backClick(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    func backClick(_ btn:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func _creatButton() {
        var m = 0
        for i in 0...2 {
            for j in 0...1 {
                //创建button
                let button = UIButtonCustom(frame: CGRect(x:CGFloat(j * Int(kScreenWidth / 2)), y:CGFloat(i * Int((kScreenHeight - 64) / 3)), width: kScreenWidth / 2, height: (kScreenHeight - 64) / 3))
                button.tag = m + 2016
                button.addTarget(self, action: #selector(DailyViewController.buttonClick(_:)), for: .touchUpInside)
                let dailyModel = self.buttonImageData[m] as! DailyModel
                button.backgroundColor = UIColor.white
                button.imgName = dailyModel.kind_icon as NSString!
                button.title = dailyModel.kind_name as NSString!
                self.view.addSubview(button)
                m += 1
            }
        }
            
    }
    
    func _loadData() {
        let params = ["daily_count":"6"]
        DataSerive.requireDataWithURL(daily_classify as NSString, params: params as NSDictionary, method: "GET", successBlock: { (operation, resust) in
            let jsonArr = resust["data"] as! NSArray
            let mArr = NSMutableArray()
            for dic in jsonArr {
                var dailyModel = DailyModel()
                dailyModel = dailyModel.initContentWithDic(dic as! NSDictionary) as! DailyModel
                mArr.add(dailyModel)
            }
            
            self.buttonImageData = mArr
            
            self._creatButton()
            
            }) { (operation, error) in
                print("请求日常用品出错\(error)")
        }
    }
    
    
    func buttonClick(_ btn:UIButton) {
        let dailySellVC = DailySellViewController()
        let dailyModel = self.buttonImageData[btn.tag - 2016] as! DailyModel
        dailySellVC.title = dailyModel.kind_name 
        dailySellVC.kind_id = dailyModel.kind_id
        let nav = UINavigationController(rootViewController: dailySellVC)
        self.present(nav, animated: true, completion: nil)
        
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
