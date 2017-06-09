//
//  MatchedHeaderModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/11.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class MatchedHeaderModel: BaseModel {

    var kind:String!
    var name:String!
    var header_items:NSArray!
    
    override func initContentWithDic(_ jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        let itemArr = jsonDic["items"] as! NSArray
        let mArr = NSMutableArray()
        for dic in itemArr {
            var itemModel = HeaderItemModel()
            itemModel = itemModel.initContentWithDic(dic as! NSDictionary) as! HeaderItemModel
            mArr.add(itemModel)
        }
        
        self.header_items = mArr
        
        return self
    }
}
