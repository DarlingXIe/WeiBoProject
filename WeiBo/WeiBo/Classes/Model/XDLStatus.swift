//
//  XDLStatus.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//
/*
    "created_at": "Tue May 31 17:46:55 +0800 2011",
    "id": 11488058246,
    "text": "求关注。"，
    "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 */
import UIKit

class XDLStatus: NSObject {
    
    var create_at: String?
    
    var id : Int64 = 0
    
    var text : String?
    
    var source : String?

    var user : XDLUsers?
    
}
