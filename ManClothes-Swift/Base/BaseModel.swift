//
//  BaseModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/17.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    
    func initContentWithDic(jsonDic: NSDictionary) -> AnyObject {
        self.setAttributes(jsonDic)
        return self
    }
    
    func setAttributes(jsonDic: NSDictionary) {
        /*
        key: json字典中的key名
        value: model对象的属性名
        */
        
        //mapDic: 属性名与json字典中的Key 的映射关系
        let mapDic = self.attributeMapDictionary(jsonDic)
        for jsonKey in mapDic.allKeys {
            //modelAttr:"newsId"
            //josnKey: "id"
            let modelAttr = mapDic.objectForKey(jsonKey) as! String
            let seletor = self.stringToSel(modelAttr)
            
            //self 是否有seletor方法
            if self.respondsToSelector(seletor) {
                //json字典中的value
                var value = jsonDic.objectForKey(jsonKey)
                let isnull = value!.isKindOfClass(NSNull.self)
                if isnull {
                    value = ""
                }
                
                //调用属性的设置器方法，参数是json的value
                self.performSelector(seletor, withObject: value)
                
            }
            
        }
    }
    
    
    private func stringToSel(attName:String) -> Selector{
        //截取首字母
        let index = attName.startIndex.advancedBy(1)
        let firstStr = attName.substringToIndex(index)
        let endStr = attName.substringFromIndex(index)
        
        let setMethod = "set" + firstStr + endStr
        
        //将字符串转换成SEL类型
        return NSSelectorFromString(setMethod)
        
    }
    
    /**
     属性名与json字典中的Key 的映射关系
     key: json字典的key名
     value: model对象的属性名
     */
    func attributeMapDictionary(jsonDic: NSDictionary) -> NSDictionary {
        let mapDic = NSMutableDictionary()
        for key in jsonDic.allKeys {
            mapDic.setObject(key, forKey: key as! String)
        }
        
        return mapDic
    }

}
