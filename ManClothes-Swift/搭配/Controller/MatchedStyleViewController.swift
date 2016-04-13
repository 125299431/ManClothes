//
//  MatchedStyleViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/12.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MatchedStyleViewController: BaseViewController , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var collectionView:UICollectionView!
    var itemData:NSArray!
    var classify_id:NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.setImage(UIImage(named: "backButton_blue.png"), forState: .Normal)
        button.addTarget(self, action: #selector(MatchedStyleViewController.backClick), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: UIColor.redColor()]
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 30, height: kScreenWidth / 2 - 50)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.lightGrayColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.view.addSubview(self.collectionView)
        
        //注册单元格
        self.collectionView.registerClass(MatchedCell.self, forCellWithReuseIdentifier: "MatchedCell")
        //下拉刷新
        self.collectionView.addHeaderWithTarget(self, action: #selector(MatchedStyleViewController._loadData))
    }
    
    func backClick() {
        
    }
    
    func _loadData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let matchedCell = collectionView.dequeueReusableCellWithReuseIdentifier("MatchedCell", forIndexPath: indexPath) as! MatchedCell
        matchedCell.isItem = true
        matchedCell.itemModel = self.itemData[indexPath.row] as! MatchedItemModel
        
        return matchedCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
