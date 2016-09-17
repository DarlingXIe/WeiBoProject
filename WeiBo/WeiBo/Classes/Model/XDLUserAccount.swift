//
//  XDLUserAccount.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
/*
 access_token	string	用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid        string
 
 name string 
 profile_image_url
 */
class XDLUserAccount: NSObject, NSCoding {

        var access_token: String?
    
        var expires_in : TimeInterval = 0{
          
            didSet{
                expiresDate = Date(timeIntervalSinceNow: expires_in)
            }
    }
    
        var expiresDate : Date?
    
        var remind_in : String?
    
        var uid : String?
    
        var name : String?
    
        var profile_image_url : String?
    
        init(dict:[String:Any])
        {
            super.init()
            setValuesForKeys(dict)
        }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
      
    }
    
    required init?(coder decoder: NSCoder) {
        
        access_token = decoder.decodeObject(forKey: "access_token") as? String
        expiresDate = decoder.decodeObject(forKey: "expiresDate") as? Date
        uid = decoder.decodeObject(forKey: "uid") as? String
        name = decoder.decodeObject(forKey: "name") as? String
        profile_image_url = decoder.decodeObject(forKey: "profile_image_url") as? String

    }
    
    
    func encode(with encoder: NSCoder){
    
        encoder.encode(access_token, forKey: "access_token")
        encoder.encode(expiresDate, forKey: "expiresDate")
        encoder.encode(uid, forKey: "uid")
        encoder.encode(name, forKey: "name")
        encoder.encode(profile_image_url, forKey: "profile_image_url")
    
    }
}
