//
//  HeaderCollectionViewCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/21.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    func _init() {
        self.imageView = UIImageView.init(frame: self.contentView.bounds)
        self.imageView.image = UIImage(named: "plaseholder.png")
        self.contentView.addSubview(self.imageView)
    }
      
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var urlStr:String? {
        willSet(newValue){
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.sd_setImage(with: URL(string: self.urlStr!))
    }
  
    
    
}
