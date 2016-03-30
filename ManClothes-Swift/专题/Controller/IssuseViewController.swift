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
    var content:NSString?
    var link:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "专题"

        // Do any additional setup after loading the view.
        self._initView()
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
        
        //注册单元格
        self.collectionView.registerClass(IssuseCell.self, forCellWithReuseIdentifier: "IssuseCell")
    }
    
    func searchItem() {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
