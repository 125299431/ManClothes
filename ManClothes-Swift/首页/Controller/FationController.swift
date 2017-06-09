//
//  FationController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/28.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class FationController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
    var fationData:NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "潮品专区"
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 400
        self.view.addSubview(self.tableView)
    }
    
    func _loadData() {
        let params = ["campaignType":"chaopin", "page":"1"]
        DataSerive.requireDataWithURL(campaign as NSString, params: params as NSDictionary, method: "GET", successBlock: { (operation, resust) in
            let itemDic = resust["data"] as! NSDictionary
            let jsonArr = itemDic["itemDetail"] as! NSArray
            let mArr = NSMutableArray()
            for dic in jsonArr {
                var homeModel = HomeModel()
                homeModel = homeModel.initContentWithDic(dic as! NSDictionary) as! HomeModel
                mArr.add(homeModel)
            }
            
            self.fationData = mArr
            self.tableView.reloadData()
            self.tableView.headerEndRefreshing()
            
            
            }) { (operation, error) in
                print("潮品页请求出错了\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fationData != nil {
            return self.fationData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "fationCell") as? FationTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("FationTableViewCell", owner: nil, options: nil)?.last as? FationTableViewCell
        }
        
        cell?.homeModel = self.fationData[indexPath.row] as? HomeModel
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buyVC = BuyViewController()
        let homeModel = self.fationData[indexPath.row] as! HomeModel
        buyVC.itemID = homeModel._id
        self.present(buyVC, animated: true, completion: nil)
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
