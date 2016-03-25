//
//  FinderViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/24.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

extension UIView {
    func viewController() -> UIViewController {
        var next = self.nextResponder()
        repeat {
            if next?.isKindOfClass(UIViewController.self) == true {
                return next as! UIViewController
            }
            next = next?.nextResponder()
        }while(next != nil)
        
        return next as! UIViewController
    }
}

class FinderViewController: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
