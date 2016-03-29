//
//  FationController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/28.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class FationController: BaseViewController {

    var tableView:UITableView!
    var fationData:NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "潮品专区"
        
        self._initView()
        
    }
    
    func _initView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .Plain)
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.rowHeight = 400
        self.view.addSubview(self.tableView)
    }
    
    func _loadData() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITableViewDelegate
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.fationData.count != 0 {
//            return self.fationData.count
//        }
//        return 0
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
