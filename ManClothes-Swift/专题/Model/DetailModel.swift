//
//  DetailModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/4/1.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DetailModel: BaseModel {
    
    var issuseModel:IssuseModel?
    var productArr:NSArray?
    
    override func initContentWithDic(jsonDic: NSDictionary) -> AnyObject {
        super.initContentWithDic(jsonDic)
        
        if jsonDic["block"] != nil{
            let issuseDic = jsonDic["block"] as! NSDictionary
            self.issuseModel = IssuseModel()
            self.issuseModel = self.issuseModel?.initContentWithDic(issuseDic) as? IssuseModel
        }
        print("\(jsonDic)")
        if jsonDic["product"]?.isKindOfClass(NSNull.self) == false{
            if jsonDic["product"]?.isKindOfClass(NSArray.self) == true {
                //有数据且为可用数据
                let proArr = jsonDic["product"] as! NSArray
                let mArr = NSMutableArray()
                for dic in proArr {
                    var productModel = ProductModel()
                    productModel = productModel.initContentWithDic(dic as! NSDictionary) as! ProductModel
                    mArr.addObject(productModel)
                }
                self.productArr = mArr
            }
        }
        
        return self
    }
    

}
