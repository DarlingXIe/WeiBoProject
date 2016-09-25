//
//  XDLStatusViewModel.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLStatusViewModel: NSObject {
    
    // member Icon
    var memberImage: UIImage?
    
    // centification for avatarImage
    var avatarImage: UIImage?
    
    // shareCounts
    var reposts_count: String?
    // commentsCounts
    var comments_count: String?
    // likesCounts
    var attitudes_count: String?

    var status:XDLStatus?{
        
        didSet{
            
            if let mbrank = status?.user?.mbrank, mbrank > 0{
            
              let imageName = "common_icon_membership_level\(mbrank)"
              
              memberImage = UIImage(named: imageName)
            }
            
            if let avar = status?.user?.verified_type, avar > 0{
                
                switch avar {
                case 1:
                    avatarImage = #imageLiteral(resourceName: "avatar_vip")
                case 2, 3, 5:
                    avatarImage = #imageLiteral(resourceName: "avatar_enterprise_vip")
                case 220:
                    avatarImage = #imageLiteral(resourceName: "avatar_grassroot")
                default:
                    break
                }
    
            }
            
        reposts_count = calCount(count: (status?.reposts_count) ?? 0, defaultTitle: "share")
            
        comments_count = calCount(count: (status?.comments_count) ?? 0, defaultTitle: "comments")
        
        attitudes_count = calCount(count: (status?.attitudes_count) ?? 0, defaultTitle: "like")
            
        }

    }
    
    private func calCount(count: Int, defaultTitle: String) -> String{
        
        if count == 0{
            
            return defaultTitle
        
        }else{
            
            if count < 10000{
                
                return "\(count)"
                
            }else{
                
                let result = count/1000
                
                let str = "\(Float(result/10))"
                
                let string = "\(str)thds"
                
                return string.replacingOccurrences(of: ".0", with: "")
            }
            
        }
        
    }
    
}
