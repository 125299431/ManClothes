//
//  SearchResultViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SearchResultViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView:UICollectionView!
    var messagelabel:UILabel!
    var typeStr:String!
    var data:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "搜索结果"
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.blueColor()]
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        let leftBtn = UIButton(type: .Custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftBtn.setImage(UIImage(named: "backButton_blue.png"), forState: .Normal)
        leftBtn.addTarget(self, action: #selector(SearchResultViewController.backClick), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        //collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 20, height: kScreenWidth / 2 + 10)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 12, 0, 12)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.view.addSubview(self.collectionView)
        
        //注册单元格
        self.collectionView.registerClass(IssuseCell.self, forCellWithReuseIdentifier: "SearchCell")
        
    }
    
    func backClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func _loadData() {
        if self.typeStr.characters.count == 0 {
            self.emptyItem()
            return
        }
        let params = NSMutableDictionary()
        params.setObject("list", forKey: "action")
        params.setObject("10", forKey: "ver")
        params.setObject("0", forKey: "page")
        params.setObject("nanren", forKey: "category")
        let category2 = "%2F" + self.typeStr
        params.setObject(category2, forKey: "category2")
        params.setObject("24", forKey: "pageSize")
        DataSerive.requireDataWithURL(json_rm, params: params, method: "GET", successBlock: { (operation, resust) in
            
            let jsonArr = resust["data"] as! NSArray
            if jsonArr.count == 0 {
                self.emptyItem()
                return
            }
            let mArr = NSMutableArray()
            for dic in jsonArr {
                var issuseModel = IssuseModel()
                issuseModel = issuseModel.initContentWithDic(dic as! NSDictionary) as! IssuseModel
                mArr.addObject(issuseModel)
            }
            self.data = mArr
            self.collectionView.reloadData()
            
            }) { (operation, error) in
                print("搜索失败！")
        }
    }
    
    func emptyItem() {
        if self.messagelabel == nil {
            self.messagelabel = UILabel(frame: CGRect(x: (kScreenWidth - 200) / 2, y: (kScreenHeight - 50 - 64) / 2, width: 200, height: 50))
            self.messagelabel.textAlignment = .Center
            self.messagelabel.text = "无相关消息"
            self.messagelabel.font = UIFont.systemFontOfSize(18)
        }
        self.view.addSubview(self.messagelabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.data != nil {
            return self.data.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SearchCell", forIndexPath: indexPath) as! IssuseCell
        cell.issuseModel = self.data[indexPath.row] as! IssuseModel
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = DetailIssuseController()
        let issuseModel = self.data[indexPath.row] as! IssuseModel
        detailVC.bgImg = issuseModel.img
        detailVC.headerTitle = issuseModel.title
        detailVC.albumId = issuseModel.albumId
        detailVC.album_type = issuseModel.album_type
        self.navigationController?.pushViewController(detailVC, animated: true)

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
