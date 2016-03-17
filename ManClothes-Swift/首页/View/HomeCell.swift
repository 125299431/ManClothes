//
//  HomeCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/16.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    //图片
    var imgView:UIImageView?
    //描述
    var descriptionLabel:UILabel?
    //价格
    var priceLabel:UILabel?
    //分界线
    var spaceView:UIView?
    //包邮图标
    var byImgView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
        
    }
    
    func _initView() {
        //颜色与边框
        self.backgroundColor = UIColor.whiteColor()
        //图片
        self.imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.width, height: self.contentView.height * 3 / 4 - 10))
        self.imgView?.image = UIImage(named: "plaseholder.png")
        self.contentView.addSubview(self.imgView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
