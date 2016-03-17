//
//  DataSerive.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/16.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

//成功调用的block
typealias SuccessDidBlock = (operation:AFHTTPRequestOperation, resust:AnyObject) -> Void
typealias FailurDidBlock = (operation:AFHTTPRequestOperation, error:NSError) -> Void

class DataSerive: NSObject {
    
    class func requireDataWithURL(urlStr:NSString, params:NSDictionary, method:NSString, successBlock:SuccessDidBlock, failueBlock:FailurDidBlock) -> AFHTTPRequestOperation{
        //发通知
        NSNotificationCenter.defaultCenter().postNotificationName("ShowLoadView", object: nil)
        
        let manager = AFHTTPRequestOperationManager()
        //请求解析方式
        manager.requestSerializer = AFHTTPRequestSerializer()
        //响应的解析方式
        manager.responseSerializer = AFHTTPResponseSerializer()
        var operation:AFHTTPRequestOperation?
        if method.isEqualToString("GET") {
            operation = manager.GET(urlStr as String, parameters: params, success: { (operation, responseObject) -> Void in
                print("请求成功！")
                NSNotificationCenter.defaultCenter().postNotificationName("HoddenLoadView", object: nil)
                successBlock(operation: operation, resust: responseObject)
                
                }, failure: { (operation, error) -> Void in
                   print("请求失败！")
                   NSNotificationCenter.defaultCenter().postNotificationName("HoddenLoadView", object: nil)
                   failueBlock(operation: operation, error: error)
                    
            })
        }
        
        return operation! as AFHTTPRequestOperation
        
        

    }

}
