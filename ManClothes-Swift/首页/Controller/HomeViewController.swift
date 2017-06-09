//
//  HomeViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var collectionView:UICollectionView!
    var homeHeaderView:HomeHeaderView!
    var data:[HomeModel]!
    var scrollerData:[HomeHerderModel]!
    var thmemeData:[HomeHerderModel]!
    
    
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
        self.collectionView!.backgroundColor = UIColor.clear
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.collectionView?.showsVerticalScrollIndicator = false
        
        //注册头视图
        self.collectionView?.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeHeader")
        self.collectionView!.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        self.view.addSubview(self.collectionView!)
        
        //下拉刷新
        self.collectionView.addHeader(withTarget: self, action: #selector(HomeViewController._loadData))
        
    }
    
    
    
    func _loadData() {
        
        //请求头视图数据
        let params = ["type":"2"]
        DataSerive.requireDataWithURL(theme as NSString, params: params as NSDictionary, method: "GET", successBlock: { (operation, resust) -> Void in
            let jsonArr = resust["data"]
            var mArr = [HomeHerderModel]()
            for dic in jsonArr as! [NSDictionary]{
                var homeHeaderModel = HomeHerderModel()
                homeHeaderModel = homeHeaderModel.initContentWithDic(dic) as! HomeHerderModel
                mArr.append(homeHeaderModel)
            }
            
            self.scrollerData = mArr
            self.homeHeaderView.scrollerData = self.scrollerData
            self.collectionView.reloadData()
            
            }) { (operation, error) -> Void in
                
        }
        
        //请求头视图专区数据
        let params1 = ["type":"3"]
        DataSerive.requireDataWithURL(theme as NSString, params: params1 as NSDictionary, method: "GET", successBlock: { (operation, resust) -> Void in
            let jsonArr = resust["data"]
            var mArr = [HomeHerderModel]()
            for dic in jsonArr as! [NSDictionary]{
                
                var headerModel = HomeHerderModel()
                headerModel = headerModel.initContentWithDic(dic) as! HomeHerderModel
                mArr.append(headerModel)
                
                
            }
            
            self.thmemeData = mArr
            self.homeHeaderView.themeData = self.thmemeData
            self.collectionView.reloadData()
            }) { (operation, error) -> Void in
                
        }
        
        //请求单元格数据
        let params0 = NSMutableDictionary()
        params0.setObject("19", forKey: "age" as NSCopying)
        params0.setObject("0", forKey: "campaignId" as NSCopying)
        params0.setObject("jingxuan", forKey: "campaignType" as NSCopying)
        params0.setObject("1", forKey: "page" as NSCopying)
        
        DataSerive.requireDataWithURL(campaign as NSString, params: params0, method: "GET", successBlock: { (operation, resust) -> Void in
            
//            print(resust)
            let jsonDic = resust["data"] as! NSDictionary
            let itemDetailArr = jsonDic["itemDetail"] as! [NSDictionary]
            var mArr = [HomeModel]()
            for dic in itemDetailArr {
//                let model = HomeModel.initContentWithDic(<#T##HomeModel#>)
                var model = HomeModel()
                model = model.initContentWithDic(dic) as! HomeModel
                mArr.append(model)
            }
            
            self.data = mArr
            
            self.collectionView?.reloadData()
            self.collectionView.headerEndRefreshing()
            
            }) { (operation, error) -> Void in
                print("单元格请求数据出错了\(error)")
                self.collectionView.headerEndRefreshing()
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.data?.count {
            return count
        }else {
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth / 2 - 30, height: 200 * (kScreenWidth / 2 - 30) / 150)
    }
    //头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        homeHeaderView  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HomeHeader", for: indexPath) as! HomeHeaderView
        return self.homeHeaderView!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
//        cell.contentView.backgroundColor = UIColor.redColor()
        cell.homeModel = self.data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buyVC = BuyViewController()
        let homeModel = self.data[indexPath.row] 
        buyVC.itemID = homeModel._id
        self.present(buyVC, animated: true, completion: nil)
    }
    



}
