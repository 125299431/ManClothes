//
//  SpaceLabel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/12.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SpaceLabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: 20, y: self.height - 1))
        
        context?.addLine(to: CGPoint(x: self.width - 20, y: self.height - 1))
        
        //设置颜色
        context?.setFillColor(UIColor.gray.cgColor)
        
        //设置画笔宽度
        context?.setLineWidth(1)
        
        context?.drawPath(using: .stroke)
        
    }

}
