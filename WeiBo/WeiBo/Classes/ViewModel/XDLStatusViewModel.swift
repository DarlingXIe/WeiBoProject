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
            
        }
    
    }
            
}
