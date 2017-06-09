//
//  DataSerive.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/16.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

//成功调用的block
typealias SuccessDidBlock = (_ operation:AFHTTPRequestOperation, _ resust:AnyObject) -> Void
typealias FailurDidBlock = (_ operation:AFHTTPRequestOperation, _ error:NSError) -> Void

class DataSerive: NSObject {
    
    class func requireDataWithURL(_ urlStr:NSString, params:NSDictionary, method:NSString, successBlock:@escaping SuccessDidBlock, failueBlock:@escaping FailurDidBlock) -> AFHTTPRequestOperation{
        //发通知
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ShowLoadView"), object: nil)
        
        let manager = AFHTTPRequestOperationManager()
        //请求解析方式
        manager.requestSerializer = AFHTTPRequestSerializer()
        //响应的解析方式
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: .mutableContainers)
        var operation:AFHTTPRequestOperation?
        if method.isEqual(to: "GET") {
            operation = manager.get(urlStr as String, parameters: params, success: { (operation, responseObject) -> Void in
                print("请求成功！")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "HiddenLoadView"), object: nil)
                successBlock(operation!, responseObject as AnyObject)
                
                }, failure: { (operation, error) -> Void in
                   print("请求失败！")
                   NotificationCenter.default.post(name: Notification.Name(rawValue: "HiddenLoadView"), object: nil)
                   failueBlock(operation!, error as! NSError)
                    
            })
        }
        
        return operation! as AFHTTPRequestOperation
        
        

    }

}
