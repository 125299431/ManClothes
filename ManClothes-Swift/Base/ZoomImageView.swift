//
//  ZoomImageView.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class ZoomImageView: UIImageView {

    var scrollView:UIScrollView?//放大后的视图上有一个scrollView
    var fullImageView:UIImageView?//放大的imageView
    var fullImageUrl:String?//图片的地址
    var tap:UITapGestureRecognizer?//放大的手势
    
    func addTapZoomImageViewWithImageUrl(_ urlStr:String) {
        self.fullImageUrl = urlStr
        self.isUserInteractionEnabled = true
        //创建手势
        if self.tap == nil {
            self.tap = UITapGestureRecognizer(target: self, action: #selector(ZoomImageView.tapToZoomBig))
            self.addGestureRecognizer(self.tap!)
        }
    }
    
    func tapToZoomBig() {
        //判断图片是否为空
        self._initView()
        //image
        let rect = self.convert(self.frame, to: self.window)
        self.fullImageView?.frame = rect
        
        //计算出图片的真实长度
        let realHeight = kScreenWidth / ((self.image?.size.width)! / (self.image?.size.height)!)
        self.scrollView?.contentSize = CGSize(width: kScreenWidth, height: realHeight)
        
        UIView.animate(withDuration: 0.35, animations: { 
             self.fullImageView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: max(realHeight, kScreenHeight))
            }, completion: { (finished) in
                if self.fullImageUrl == nil {
                    return
                }
                
                self.fullImageView?.sd_setImage(with: URL(string: self.fullImageUrl!), placeholderImage: self.image)
        }) 
       
    }
    
    func _initView() {
        if self.scrollView == nil {
            self.scrollView = UIScrollView(frame: UIScreen.main.bounds)
            let tapToSamll = UITapGestureRecognizer(target: self, action: #selector(ZoomImageView.tapToSmall))
            self.scrollView?.backgroundColor = UIColor.black
            self.scrollView?.addGestureRecognizer(tapToSamll)
            self.window?.addSubview(self.scrollView!)
        }
        
        if self.fullImageView == nil {
            self.fullImageView = UIImageView(frame: CGRect.zero)
            self.fullImageView?.image = self.image
            self.fullImageView?.contentMode = .scaleAspectFit
            self.scrollView?.addSubview(self.fullImageView!)
        }
        
    }
    
    
    func tapToSmall() {
        UIView.animate(withDuration: 0.35, animations: { 
            //缩小到原来的位置
            self.fullImageView?.frame = self.convert(self.frame, to: self.window)
            self.scrollView?.backgroundColor = UIColor.clear
            }, completion: { (finished) in
                self.fullImageView?.removeFromSuperview()
                self.fullImageView = nil
                self.scrollView?.removeFromSuperview()
                self.scrollView = nil
        }) 
    }
    
    
    
    

}



