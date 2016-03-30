//
//  SellModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SellModel: BaseModel {

    var _id:NSNumber?
    var item_id:NSNumber?
    var pic_url:NSString?
    var title:NSString?
    var coupon_price:NSString?
    var price:NSString?
    var saveCount:NSNumber?
    var brand:NSString?
    var num_iid:NSNumber?
    var purchaseLink:NSString?
    var style:NSString?
    var material:NSString?
    var color:NSString?
    var season:NSString?
    var size:NSString?
    var cloth_description:NSString?
    
    override func initContentWithDic(jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        self.cloth_description = jsonDic.objectForKey("description") as? NSString
        return self
    }
}
