//
//  HeaderSellController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/23.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HeaderSellController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var itemData:[HomeModel]?
    var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._init()
        self._creatSementControl()
        self._initCollectionView()
        self._loadData(9.9)
    }
    
    func _init() {
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.setImage(UIImage(named: "backButton_blue.png"), forState: .Normal)
        button.addTarget(self, action: #selector(HeaderSellController.backClick(_:)), forControlEvents: .TouchUpInside)
        let buttonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = buttonItem
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
    }
    
    func backClick(btn:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //创建分段控件
    func _creatSementControl() {
        //创建按钮标题
        let titleArr = ["9块9","19块9","29块9"]
        //创建分段控件
        let segementedControl = UISegmentedControl(items: titleArr)
        segementedControl.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        //默认选中按钮
        segementedControl.selectedSegmentIndex = 0
        segementedControl.tintColor = UIColor.whiteColor()
        segementedControl.setTitleTextAttributes([NSFontAttributeName:
        UIFont.systemFontOfSize(15)],forState: .Normal)
        segementedControl.addTarget(self, action: #selector(HeaderSellController.segmentedCtrlAction(_:)), forControlEvents: .ValueChanged)
        self.navigationItem.titleView = segementedControl
        
    }
    
    func segmentedCtrlAction(segemented:UISegmentedControl) {
        switch segemented.selectedSegmentIndex {
        case 0:
            self._loadData(9.9)
            break
        case 1:
            self._loadData(19.9)
            break
        case 2:
            self._loadData(29.9)
            break
            
        default:
            break
        }
    }
    
    
    func _initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 30, height: 200 * (kScreenWidth / 2 - 30) / 150)
        //每组头视图的高度
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 15)
        //左右偏移量
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.collectionView)
        //注册单元格
        self.collectionView.registerClass(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
    }
    
    //加载数据
    func _loadData(price:CGFloat) {
        let params = NSMutableDictionary()
        params.setObject("0", forKey: "campaignId")
        params.setObject("\(price)", forKey: "campaignType")
        params.setObject("15243", forKey: "member_id")
        params.setObject("member", forKey: "member_type")
        params.setObject("1", forKey: "page")
        params.setObject("24255", forKey: "random_key")
        DataSerive.requireDataWithURL(campaign, params: params, method: "GET", successBlock: { (operation, resust) in
            
            let jsonDic = resust["data"] as! NSDictionary
            let itemDetailArr = jsonDic["itemDetail"] as! NSArray
            var mArr = [HomeModel]()
            for dic in itemDetailArr {
                var model = HomeModel()
                model = model.initContentWithDic(dic as! NSDictionary) as! HomeModel
                mArr.append(model)
            }
            
            self.itemData = mArr
            self.collectionView.reloadData()
            
            }) { (operation, error) in
               print("特价请求数据出错了\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((self.itemData?.count) != nil) {
            return (self.itemData?.count)!
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        cell.isBaoyou = true
        cell.homeModel = self.itemData![indexPath.row]
        return cell
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
