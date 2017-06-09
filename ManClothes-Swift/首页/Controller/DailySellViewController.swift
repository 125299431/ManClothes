//
//  DailySellViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/29.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DailySellViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView:UICollectionView!
    var kind_id:NSNumber!
    var itemData:NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.blue]
        
        self._initView()
        self._creatCollectionView()
        self._loadData()
        
    }
    
    func _initView() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftBtn.setImage(UIImage(named: "backButton_blue.png"), for: UIControlState())
        leftBtn.addTarget(self, action: #selector(DailySellViewController.backClick(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    func backClick(_ btn:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func _creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 30, height: 200 * (kScreenWidth / 2 - 30) / 150)
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 15)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        
        //下拉刷新
        self.collectionView.addHeader(withTarget: self, action: #selector(DailySellViewController._loadData))
    }
    
    
    func _loadData() {
        let params = ["page":"1", "kind_id": self.kind_id] as [String : Any]
        DataSerive.requireDataWithURL(daily_items as NSString, params: params as NSDictionary, method: "GET", successBlock: { (operation, resust) in
            let itemDetailArr = resust["data"] as! NSArray
            let mArr = NSMutableArray()
            for dic in itemDetailArr {
                var homeModel = HomeModel()
                homeModel = homeModel.initContentWithDic(dic as! NSDictionary) as! HomeModel
                mArr.add(homeModel)
            }
            
            self.itemData = mArr
            self.collectionView.reloadData()
            self.collectionView.headerEndRefreshing()
            
            }) { (operation, error) in
                self.collectionView.headerEndRefreshing()
                print("日常洗护出错了\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.itemData != nil{
            return self.itemData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.homeModel = self.itemData[indexPath.row] as? HomeModel
        cell.isRightRangle = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webVC = HeaderWebController()
        webVC.title = "宝贝详情"
        let homeModel = self.itemData[indexPath.row] as! HomeModel
        webVC.urlStr = homeModel.purchaseLink as NSString!
        let nav = UINavigationController(rootViewController: webVC)
        self.present(nav, animated: true, completion: nil)
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
