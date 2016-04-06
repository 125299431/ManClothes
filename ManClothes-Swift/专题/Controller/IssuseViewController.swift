//
//  IssuseViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class IssuseViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView:UICollectionView!
    var data:NSArray!
    var content:String?
    var link:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "专题"

        // Do any additional setup after loading the view.
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        let searchBtn = UIButton(type: .Custom)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchBtn.setBackgroundImage(UIImage(named: "searchDot.png"), forState: .Normal)
        searchBtn.addTarget(self, action: #selector(IssuseViewController.searchItem), forControlEvents: .TouchUpInside)
        let rightItem = UIBarButtonItem(customView: searchBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 20, height: kScreenWidth / 2 + 10)
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 160)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 12, 0, 12)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.view.addSubview(self.collectionView)
        
        //注册头视图
        self.collectionView.registerClass(IssuseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "IssuseHeader")
        //注册单元格
        self.collectionView.registerClass(IssuseCell.self, forCellWithReuseIdentifier: "IssuseCell")
        //下拉刷新
        self.collectionView.addHeaderWithTarget(self, action: #selector(IssuseViewController._loadData))
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("list", forKey: "action")
        params.setObject("10", forKey: "ver")
        params.setObject("0", forKey: "page")
        params.setObject("nanren", forKey: "category")
        params.setObject("24", forKey: "pagesize")
        
        DataSerive.requireDataWithURL(json_rm, params: params, method: "GET", successBlock: { (operation, resust) in
            let headerDic = resust["top"] as! NSDictionary
            let headerArr = headerDic["data"] as! NSArray
            if headerArr.count != 0 {
                let contenDic = headerArr[0] as! NSDictionary
                self.content = contenDic["content"] as? String
                self.link = contenDic["link"] as? String
            }
            
            //item
            let jsonArr = resust["data"] as! NSArray
            let mArr = NSMutableArray()
            for dic in jsonArr{
                var issuseModel = IssuseModel()
                issuseModel = issuseModel.initContentWithDic(dic as! NSDictionary) as! IssuseModel
                mArr.addObject(issuseModel)
            }
            
            self.data = mArr;
            self.collectionView.reloadData()
            self.collectionView.headerEndRefreshing()
            
            }) { (operation, error) in
              self.collectionView.headerEndRefreshing()  
        }
    }
    
    func searchItem() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IssuseCell", forIndexPath: indexPath) as! IssuseCell
        cell.issuseModel = self.data[indexPath.row] as! IssuseModel
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "IssuseHeader", forIndexPath: indexPath) as! IssuseHeaderView
        headerView.content = self.content
        headerView.link = self.link
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = DetailIssuseController()
        let issuseModel = self.data[indexPath.row] as! IssuseModel
        detailVC.issueModel = issuseModel
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
