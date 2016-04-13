//
//  MatchedViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/15.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MatchedViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView:UICollectionView!
    var edgHeight:CGFloat!//偏移量
    var itemData:NSArray!
    var matchedHeaderModel:MatchedHeaderModel!
    var hArr:NSMutableArray!//用来装单元格高度的数组
//    var matchHeaderView:MatchedHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搭配"

        // Do any additional setup after loading the view.
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 250)
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.init(red: 192 / 255.0, green: 192 / 255.0, blue: 192 / 255.0, alpha: 1)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        
        //注册头视图
        self.collectionView.registerClass(MatchedHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MatchedHeader")
        //注册单元格
//        self.collectionView.registerClass(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
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
        //2列瀑布流
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MatchedCell", forIndexPath: indexPath) as! MatchedCell
        //当前列
        let remaineder:Int = indexPath.row % 2
        //当前行数
        let currentRow:Int = indexPath.row / 2
        
        //取出单元格的高度
        let currentHeight = self.hArr[indexPath.row].floatValue
        //算出cell的x的起始坐标
        let positonX = (kScreenWidth / 2 - 8) * CGFloat(remaineder) + 5 * (CGFloat(remaineder) + 1)
        //算出cell的y的起始位置
        var positionY:Float = (Float(currentRow) + 1) * 5
        
        for i in 0...currentRow - 1 {
            //遍历出此列的单元格之前的所有的单元格的下标，然后将其对应的高度相加，求出高度
            let positon = remaineder + i * 2
            positionY += self.hArr[positon].floatValue
        }
        
        //从新定义单元格的位置以及高度
        cell.frame = CGRect(x: positonX, y: 250 - 75 + CGFloat(positionY), width: kScreenWidth / 2 - 8, height: CGFloat(currentHeight))
        cell.itemModel = self.itemData[indexPath.row] as! MatchedItemModel
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let matchedHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MatchedHeader", forIndexPath: indexPath) as! MatchedHeaderView
        return matchedHeaderView
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = self.hArr[indexPath.row] as! NSNumber
        return CGSize(width: kScreenWidth / 2 - 8, height: CGFloat(height.floatValue))
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, -self.edgHeight, 0)
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
