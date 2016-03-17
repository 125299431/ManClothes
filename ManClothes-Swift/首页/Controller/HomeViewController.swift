//
//  HomeViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var collectionView:UICollectionView?
    var homeHeaderView:HomeHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
        self._initCollectionView()
        
        self._loadData()

    }
    
    
    func _initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
//        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 30, height: 200 * (kScreenWidth / 2 - 30) / 150)
        //头视图的size
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 250)
        //单元格偏移量
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView!.backgroundColor = UIColor.clearColor()
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.collectionView?.showsVerticalScrollIndicator = false
        
        //注册头视图
        self.collectionView?.registerClass(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeHeader")
        self.collectionView!.registerClass(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        self.view.addSubview(self.collectionView!)
        
        
    }
    
    
    func _loadData() {
        //请求单元格数据
        let params0 = NSMutableDictionary()
        params0.setObject("19", forKey: "age")
        params0.setObject("0", forKey: "campaignId")
        params0.setObject("jingxuan", forKey: "campaignType")
        params0.setObject("1", forKey: "page")
        
        DataSerive.requireDataWithURL(campaign, params: params0, method: "GET", successBlock: { (operation, resust) -> Void in
            
            print(resust)
            let jsonDic = resust["data"] as! NSDictionary
            let itemDetailArr = jsonDic["itemDetail"] as! [NSDictionary]
            let mArr = []
            for dic in itemDetailArr {
                
            }
            
            
            }) { (operation, error) -> Void in
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: kScreenWidth / 2 - 30, height: 200 * (kScreenWidth / 2 - 30) / 150)
    }
    //头视图
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        homeHeaderView  = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeHeader", forIndexPath: indexPath) as? HomeHeaderView
        return self.homeHeaderView!
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath)
//        cell.contentView.backgroundColor = UIColor.redColor()
        return cell
    }
    



}
