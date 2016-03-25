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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, 25, (self.height - 1) / 2)
        
        CGContextAddLineToPoint(context, self.width / 2 - 25, (self.height - 1) / 2)
        
        CGContextMoveToPoint(context, self.width / 2 + 25, (self.height - 1) / 2)
        
        CGContextAddLineToPoint(context, self.width - 25, (self.height - 1) / 2)
        
        //设置颜色
        CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor)
        
        //设置画笔宽度
        CGContextSetLineWidth(context, 0.5)

        CGContextDrawPath(context, .Stroke)
        
        let text = "精选" 
        text.drawInRect(CGRect(x: (kScreenWidth - 50) / 2 + 13, y: (self.height - 20) / 2, width: 50, height: 20), withAttributes:[NSFontAttributeName:UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        
    }

}


