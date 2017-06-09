//
//  UIButtonCustom.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/29.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class UIButtonCustom: UIButton {

    
    var imgView:UIImageView!
    var titleLa: UILabel!
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.imgView = UIImageView(frame: CGRect(x: (self.width - 80) / 2, y: (self.height - 80) / 2 - 10, width: 80, height: 80))
        self.addSubview(self.imgView)
        
        self.titleLa = UILabel(frame: CGRect(x: 0, y: self.imgView.bottom - 10, width: self.width, height: 50))
        self.titleLa.textAlignment = .center
        self.titleLa.textColor = UIColor.blue
        self.titleLa.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.titleLa)
        
    }
    
    var imgName:NSString! {
        willSet(newValue){
            self.imgView.sd_setImage(with: URL(string: newValue as String))
        }
        
        didSet(oldValue) {
            
        }
    }
    var title:NSString! {
        willSet(newValue) {
            self.titleLa.text = String(newValue)
        }
        
        didSet(oldValue) {
            
        }
    }

}
