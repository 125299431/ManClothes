//
//  SellModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SellModel: BaseModel {

    var _id:NSNumber!
    var item_id:NSNumber!
    var pic_url:String!
    var title:String!
    var coupon_price:String!
    var price:String!
    var saveCount:NSNumber!
    var brand:String!
    var num_iid:NSNumber!
    var purchaseLink:String!
    var style:String!
    var material:String!
    var color:String!
    var season:String!
    var size:String!
    var cloth_description:String!
    
    override func initContentWithDic(_ jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        self.cloth_description = jsonDic.object(forKey: "description")  as? String
        return self
    }
}
