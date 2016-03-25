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
    var imgView:UIImageView!
    //描述
    var descriptionLabel:UILabel!
    //价格
    var priceLabel:UILabel!
    //分界线
    var spaceView:UIView!
    //包邮图标
    var byImgView:UIImageView!
    //是否包邮
    var isBaoyou:Bool?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
        
    }
    
    func _initView() {
        //颜色与边框
        self.contentView.backgroundColor = UIColor.whiteColor()
//        //图片
        self.imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.width, height: self.contentView.height * 3 / 4 - 10))
        self.imgView.image = UIImage(named: "plaseholder.png")
        self.contentView.addSubview(self.imgView!)
        
        //描述
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: self.imgView.bottom, width: self.contentView.width, height: 30))
//        self.descriptionLabel.backgroundColor = UIColor.redColor()
        self.descriptionLabel.text = "【秋季上新】男士新款"
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.font = UIFont.systemFontOfSize(12)
        self.contentView.addSubview(self.descriptionLabel)
        
        //分界线
        self.spaceView = UIView(frame: CGRect(x: (self.contentView.width - self.contentView.width * 4 / 5) / 2, y: self.descriptionLabel.bottom, width: self.contentView.width * 4 / 5, height: 0.5))
        self.spaceView.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(self.spaceView)
        
        //价格
        self.priceLabel = UILabel(frame: CGRect(x: 0, y: self.spaceView.bottom, width: self.contentView.width, height: self.contentView.height - self.spaceView.bottom))
        self.priceLabel.text = "¥100.00"
        self.priceLabel.font = UIFont.systemFontOfSize(17.0)
        self.priceLabel.textColor = UIColor.redColor()
        self.contentView.addSubview(self.priceLabel)
        
        //包邮图标
        self.byImgView = UIImageView(frame: CGRect(x: self.width - 45, y: self.spaceView.bottom + 5, width: 32, height: 20))
        self.byImgView.hidden = true
        self.byImgView.image = UIImage(named: "baoyou.png")
        self.contentView.addSubview(self.byImgView)
    }

    //加载xib用到
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //属性监视器
    var homeModel:HomeModel? {
        willSet(newValue){
            self.setNeedsLayout()
        }
        didSet(oldValue){
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //图片
        imgView?.sd_setImageWithURL(NSURL(string: self.homeModel!.pic_url!))
        
        //描述
        self.descriptionLabel.text = self.homeModel?.title
        
        //价格
        self.priceLabel.text =  "¥" + String(stringInterpolationSegment: Int((self.homeModel?.coupon_price)!))
        
        if self.isBaoyou == true {
            self.byImgView.hidden = false
        }
        
        
        
        
    }
    
}
