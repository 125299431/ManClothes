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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.isWithStrikeThrough == true {
            let context = UIGraphicsGetCurrentContext()
            context?.move(to: CGPoint(x: 0, y: (self.height - 1) / 2))
            context?.addLine(to: CGPoint(x: self.width, y: (self.height - 1) / 2))
            //设置颜色
            context?.setStrokeColor(UIColor.black.cgColor)
            //设置画笔宽度
            context?.setLineWidth(1)
            context?.drawPath(using: .stroke)
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
