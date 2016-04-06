//
//  IssuseHeaderView.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/1.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class IssuseHeaderView: UICollectionReusableView {
    
    var imgView:UIImageView!
    var link:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        self._initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        self.imgView = UIImageView(frame: self.bounds)
        self.userInteractionEnabled = true
        self.addSubview(self.imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(IssuseHeaderView.tapForTianM(_:)))
        self.imgView.addGestureRecognizer(tap)
    }
    
    func tapForTianM(tap:UITapGestureRecognizer) {
        if self.link != nil {
            let webVC = HeaderWebController()
            webVC.urlStr = self.link
            webVC.title = "聚划算"
            let nav = UINavigationController(rootViewController: webVC)
            self.viewController().presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    var content:String? {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.content != nil {
            self.imgView.sd_setImageWithURL(NSURL(string: self.content!))
        }
        
    }

    
    
    
    
}
