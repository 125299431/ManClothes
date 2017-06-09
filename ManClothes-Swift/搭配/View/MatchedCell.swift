//
//  MatchedCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/12.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MatchedCell: UICollectionViewCell {
    
    var imgView:UIImageView!
    var descriptionLabel:SpaceLabel!
    var typeLabel:UILabel!
    var isItem:Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        //颜色与边框
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius  = 10
        self.contentView.layer.masksToBounds = true
        
        //图片
        self.imgView = UIImageView(frame: CGRect.zero)
        self.contentView.addSubview(self.imgView)
        
        //描述
        self.descriptionLabel = SpaceLabel(frame: CGRect(x: 0, y: self.imgView.bottom, width: self.contentView.width, height: 30))
        self.descriptionLabel.text = "【秋季上新】男士新款"
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(self.descriptionLabel)
        
        //类型
        self.typeLabel = UILabel(frame: CGRect.zero)
        self.typeLabel.textColor = UIColor.blue
        self.typeLabel.numberOfLines = 2
        self.typeLabel.textAlignment = .center
        self.typeLabel.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(self.typeLabel)
 
    }
    
    var itemModel:MatchedItemModel! {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
        
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isItem == true{
            //不是瀑布流
            self.imgView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.contentView.height - 50)
        }else {
            //是瀑布流
            let rowHeight = Float((kScreenWidth / 2 - 8)) * self.itemModel.height.floatValue / self.itemModel.width.floatValue
            self.imgView.frame = CGRect(x: 0, y: 0, width: self.width, height:CGFloat(rowHeight - 50))
        }
        
        self.imgView.sd_setImage(with: URL(string: self.itemModel.big_image), placeholderImage: UIImage(named: "plaseholder.png"))
        //title
        self.descriptionLabel.frame = CGRect(x: 0, y: self.imgView.bottom, width: self.imgView.width, height: 30)
        self.descriptionLabel.text = self.itemModel.info
        //类型
        self.typeLabel.frame = CGRect(x: 0, y: self.descriptionLabel.bottom, width: self.imgView.width, height: 20)
        self.typeLabel.text = self.itemModel.collocation_type
    }
    
    
}
