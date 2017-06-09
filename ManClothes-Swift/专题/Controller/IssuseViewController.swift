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
        let searchBtn = UIButton(type: .custom)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchBtn.setBackgroundImage(UIImage(named: "searchDot.png"), for: UIControlState())
        searchBtn.addTarget(self, action: #selector(IssuseViewController.searchItem), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: searchBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 20, height: kScreenWidth / 2 + 10)
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 160)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 12, 0, 12)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.view.addSubview(self.collectionView)
        
        //注册头视图
        self.collectionView.register(IssuseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "IssuseHeader")
        //注册单元格
        self.collectionView.register(IssuseCell.self, forCellWithReuseIdentifier: "IssuseCell")
        //下拉刷新
        self.collectionView.addHeader(withTarget: self, action: #selector(IssuseViewController._loadData))
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("list", forKey: "action" as NSCopying)
        params.setObject("10", forKey: "ver" as NSCopying)
        params.setObject("0", forKey: "page" as NSCopying)
        params.setObject("nanren", forKey: "category" as NSCopying)
        params.setObject("24", forKey: "pagesize" as NSCopying)
        
        DataSerive.requireDataWithURL(json_rm as NSString, params: params, method: "GET", successBlock: { (operation, resust) in
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
                mArr.add(issuseModel)
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.data != nil {
            return self.data.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IssuseCell", for: indexPath) as! IssuseCell
        cell.issuseModel = self.data[indexPath.row] as! IssuseModel
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "IssuseHeader", for: indexPath) as! IssuseHeaderView
        headerView.content = self.content
        headerView.link = self.link
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
