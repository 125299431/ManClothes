//
//  DetailCollectionView.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DetailCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var productArr:NSArray!
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = self
        self.dataSource = self
        self.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "DetailCell")
        
    }
    
    
    //MARK:UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCell", forIndexPath: indexPath)
        let imgView = UIImageView(frame: cell.contentView.bounds)
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        let productModel = self.productArr[indexPath.row] as! ProductModel
        imgView.sd_setImageWithURL(NSURL(string: productModel.img), placeholderImage: UIImage(named: "plaseholder.png"))
        cell.contentView.addSubview(imgView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //判断单元格的数量
        if self.productArr.count % 2 == 0 {
            //偶数
            return CGSize(width: (kScreenWidth - 50) / 2, height: (kScreenWidth - 50) / 2)
        }else {
            //基数
            if indexPath.row == 0 {
                return CGSize(width: kScreenWidth - 60, height: kScreenWidth - 60)
            }else {
                return CGSize(width: (kScreenWidth - 50) / 2, height: (kScreenWidth - 50) / 2)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productModel = self.productArr[indexPath.row] as! ProductModel
        let webVC = HeaderWebController()
        webVC.urlStr = productModel.url
        webVC.title = "商品详情"
        self.viewController().navigationController?.pushViewController(webVC, animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
