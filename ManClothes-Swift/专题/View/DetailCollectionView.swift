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
