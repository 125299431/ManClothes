//
//  IssuseModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class IssuseModel: BaseModel {
    
    var albumId:NSNumber?
    var album_type:NSNumber?
    var title:NSString?
    var img:NSString?
    
    var block_type:NSNumber?
    var article:NSString?
    
    override func initContentWithDic(jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        if self.article?.length >= 4 {
            let pictureUrl = self.article?.substringToIndex(4)
            if pictureUrl == "http" {
                //图片
                //把竖杠以及之后的字段删除
                let range = self.article?.rangeOfString("|")
                if range?.length != 0 {
                    self.article = self.article?.substringToIndex((range?.location)!)
                }
                
            }
        }
        
        return self
    }
    

}
