//
//  IssuseModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class IssuseModel: BaseModel {
    
    var albumId:NSNumber?
    var album_type:NSNumber?
    var title:String?
    var img:String?
    
    var block_type:NSNumber?
    var article:NSString?
    
    override func initContentWithDic(_ jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        if self.article?.length >= 4 {
            let pictureUrl = self.article?.substring(to: 4)
            if pictureUrl == "http" {
                //图片
                //把竖杠以及之后的字段删除
                let range = self.article?.range(of: "|")
                if range?.length != 0 {
                    self.article = self.article?.substring(to: (range?.location)!) as NSString?
                }
                
            }
        }
        
        return self
    }
    

}
