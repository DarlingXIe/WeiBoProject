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
    
    var created_at: Date?
    
    var id : Int64 = 0
    
    var text : String?
    
    var source : String?

    var user : XDLUsers?
    
    var reposts_count: Int = 0

    var comments_count: Int = 0
    
    var attitudes_count: Int = 0
    
    var retweeted_status: XDLStatus?
    
    var retweeted_status_text: String?{
        
        didSet{
            
            if let text = retweeted_status?.user?.name, let name = retweeted_status?.text{
                
                retweeted_status_text = "@\(text):\(name)"
                
                
            }
        }
    
    }
    
    //oriPictureWithText
    var pic_urls : [XDLStatusPictureInfo]?
    
    class func modelContainerPropertyGenericClass() -> ([String: Any]) {
       
        return [
            "pic_urls": XDLStatusPictureInfo.self
        ]
    }
    
}
