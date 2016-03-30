//
//  UILabelStrikeThrough.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class UILabelStrikeThrough: UILabel {

    var isWithStrikeThrough:Bool?
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if self.isWithStrikeThrough == true {
            let context = UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(context, 0, (self.height - 1) / 2)
            CGContextAddLineToPoint(context, self.width, (self.height - 1) / 2)
            //设置颜色
            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
            //设置画笔宽度
            CGContextSetLineWidth(context, 1)
            CGContextDrawPath(context, .Stroke)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
