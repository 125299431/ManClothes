//
//  PhotoModel.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/27.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit
/*"data": [
{
"haokanme_id": 852,
"image": "http://im01.nanyibang.com/haokanme/2015/9/30/35213-6323-1443551269.jpg?hkbgcolor=f5eaea",
"like_count": 2,
"member_id": 35213,
"create_time": "2015-09-30 02:28:17",
"comment": "求搭哦",
"head_pic": "http://q.qlogo.cn/qqapp/1103427270/DC0F19B259EA8AAC8BD241E90C5D3E1F/100",
"nick_name": "☆梁小帅り"
},
*/

class PhotoModel: BaseModel {
    
    var haokanme_id:NSNumber?
    var image:String?
    var like_count:NSNumber?
    var member_id:NSNumber?
    var create_time:String?
    var comment:String?
    var head_pic:String?
    var nick_name:String?

}
