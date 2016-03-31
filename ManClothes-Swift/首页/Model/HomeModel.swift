//
//  HomeModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/17.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit
/*
"itemDetail": [
{
"_id": 300693,
"pic_url": "http://img02.taobaocdn.com/bao/uploaded/i2/TB1K.oLJpXXXXcLXpXXXXXXXXXX_!!0-item_pic.jpg_450x10000q75.jpg",
"title": "【秋装上新】男士秋款韩版修身几何印花套头卫衣日系圆领卫衣外套潮男上衣",
"coupon_price": "89.00",
"price": "198.00",
"saveCount": 173
},
*/

//潮品专区
/*
"itemDetail": [
{
"_id": 300717,
"pic_url": "http://img01.taobaocdn.com/bao/uploaded/i1/TB1Oa0iJXXXXXXoapXXXXXXXXXX_!!0-item_pic.jpg_450x10000q75.jpg",
"title": "DUSTY秋季男士黑白英文数字印花长袖衬衫丝光高街潮流衬衣潮牌",
"coupon_price": "293.00",
"price": "419.00",
"saveCount": 109,
"icon_type": 2,
"description": "印花长袖衬衫"
},
{
*/

class HomeModel: BaseModel {
    
    var _id:NSNumber?
    var pic_url:String?
    var title:String?
    var coupon_price:String?
    var price:NSNumber?
    var saveCount:NSNumber?
    var cloth_description:String?
    var icon_type:NSNumber?
    var purchaseLink:String?
    

    
    override func initContentWithDic(jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        //特殊处理
        self.cloth_description = jsonDic.objectForKey("description") as? String
        
        return self
    }
    

}
