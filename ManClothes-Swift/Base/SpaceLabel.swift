//
//  SpaceLabel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/12.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SpaceLabel: UILabel {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, 20, self.height - 1)
        
        CGContextAddLineToPoint(context, self.width - 20, self.height - 1)
        
        //设置颜色
        CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        
        //设置画笔宽度
        CGContextSetLineWidth(context, 1)
        
        CGContextDrawPath(context, .Stroke)
        
    }

}
