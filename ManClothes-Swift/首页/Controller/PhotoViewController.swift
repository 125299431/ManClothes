//
//  PhotoViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/25.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class PhotoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
    var photoData:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self._init()
        self._loadData()
    }
    
    func _init() {
        self.title = "照片墙"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName:UIColor.red]
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftBtn.setImage(UIImage(named: "backButton_blue.png"), for: UIControlState())
        leftBtn.addTarget(self, action: #selector(PhotoViewController.backClick), for: .touchUpInside)
        let item = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = item
        
        self._creatTabbleView()
    }
    
    func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func _creatTabbleView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 400
        self.view.addSubview(self.tableView)
        
        //下拉刷新
        self.tableView.addHeader(withTarget: self, action: #selector(PhotoViewController._loadData))
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("15243", forKey: "member_id" as NSCopying)
        params.setObject("member", forKey: "member_type" as NSCopying)
        params.setObject("1", forKey: "page" as NSCopying)
        params.setObject("1", forKey: "public" as NSCopying)
        params.setObject("38388", forKey: "random_key" as NSCopying)
        
        DataSerive.requireDataWithURL(photoMall as NSString, params: params, method: "GET", successBlock: { (operation, resust) in
            let jsonArr = resust["data"] as! NSArray
            var mArr = [PhotoModel]()
            for dic in jsonArr {
                var model = PhotoModel()
                model = model.initContentWithDic(dic as! NSDictionary) as! PhotoModel
                mArr.append(model)
            }
            
            self.photoData = mArr as NSArray!
            
            self.tableView.reloadData()
            self.tableView.headerEndRefreshing()
            
            }) { (operation, error) in
               print("照片墙页面出错了\(error)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.photoData != nil {
            return self.photoData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as? PhotoViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("PhotoViewCell", owner: self, options: nil)?.last as? PhotoViewCell
            
        }
        cell!.photoModel = self.photoData[indexPath.row] as? PhotoModel
        return cell!
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
