//
//  DrawLabel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/21.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DrawLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: 25, y: (self.height - 1) / 2))
        
        context?.addLine(to: CGPoint(x: self.width / 2 - 25, y: (self.height - 1) / 2))
        
        context?.move(to: CGPoint(x: self.width / 2 + 25, y: (self.height - 1) / 2))
        
        context?.addLine(to: CGPoint(x: self.width - 25, y: (self.height - 1) / 2))
        
        //设置颜色
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        
        //设置画笔宽度
        context?.setLineWidth(0.5)

        context?.drawPath(using: .stroke)
        
        let text = "精选" 
        text.draw(in: CGRect(x: (kScreenWidth - 50) / 2 + 13, y: (self.height - 20) / 2, width: 50, height: 20), withAttributes:[NSFontAttributeName:UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray])
        
    }

}


