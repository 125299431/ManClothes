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
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.setImage(UIImage(named: "backButton_blue.png"), for: UIControlState())
        button.addTarget(self, action: #selector(MatchedStyleViewController.backClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.red]
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: kScreenWidth / 2 - 30, height: kScreenWidth / 2 - 50)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.lightGray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        self.view.addSubview(self.collectionView)
        
        //注册单元格
        self.collectionView.register(MatchedCell.self, forCellWithReuseIdentifier: "MatchedCell")
        //下拉刷新
        self.collectionView.addHeader(withTarget: self, action: #selector(MatchedStyleViewController._loadData))
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let matchedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchedCell", for: indexPath) as! MatchedCell
        matchedCell.isItem = true
        matchedCell.itemModel = self.itemData[indexPath.row] as! MatchedItemModel
        
        return matchedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
