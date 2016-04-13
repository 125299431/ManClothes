//
//  MatchedHeaderView.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/11.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MatchedHeaderView: UICollectionReusableView {
    var bgView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initView() {
        self.bgView = UIView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: 250))
        self.bgView.backgroundColor = UIColor.whiteColor()
        //主题label
        let themeLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 150, height: 30))
        themeLabel.tag = 200
        themeLabel.font = UIFont.systemFontOfSize(15.0)
        themeLabel.text = "主题名称"
        self.bgView.addSubview(self.bgView)
        
        //button
        var m:Int = 0
        for i in 0...1 {
            for j in 0...3 {
                let button = UIButton(type: .Custom)
                button.layer.cornerRadius = 30
                button.layer.masksToBounds = true
                button.backgroundColor = UIColor.redColor()
                button.tag = 300 + m
                button.frame = CGRect(x: 15 + CGFloat(j) * kScreenWidth / 4, y: 40 + CGFloat(i) * self.bgView.height, width: 60, height: 60)
                self.bgView.addSubview(button)
                
                //label
                let titleLabel = UILabel(frame: CGRect(x: button.left, y: button.bottom, width: button.width, height: 20))
                titleLabel.tag = 400 + m
                titleLabel.text = "风格"
                titleLabel.font = UIFont.systemFontOfSize(12)
                titleLabel.textAlignment = .Center
                self.bgView.addSubview(titleLabel)
                m += 1
            }
        }
        
        let drawLabel = DrawLabel(frame: CGRect(x: 0, y: self.bgView.bottom, width: kScreenWidth, height: 30))
        self.addSubview(drawLabel)
    }
    
    var headerModel:MatchedHeaderModel! {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let themeLabel = self.bgView.viewWithTag(200) as! UILabel
        themeLabel.text = self.headerModel.name
        for i in 0...7 {
            let button = self.bgView.viewWithTag(300 + i) as! UIButton
            let itemModel = self.headerModel.header_items[i] as! HeaderItemModel
            button.sd_setBackgroundImageWithURL(NSURL(string: itemModel.classify_icon), forState: .Normal)
            button.addTarget(self, action: #selector(MatchedHeaderView.btnClick(_:)), forControlEvents: .TouchUpInside)
            let titleLabel = self.bgView.viewWithTag(400 + i) as! UILabel
            titleLabel.text = itemModel.classify_name
        }
    }
    
    func btnClick(btn:UIButton) {
//        let styleVC = 
//        let itemModel = self.headerModel.header_items[btn.tag - 300] as! HeaderItemModel
        
        
    }
    
    
}
