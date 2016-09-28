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
    // dealWith source
    var sourceString: String?
    // dealWith createtime
    var createTime : String?
    
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
            
             if let source = status?.source{
                
                if let preRange = source.range(of: "\">"), let sufRange = source.range(of: "</"){
                    
                    let result = source.substring(with: preRange.upperBound..<sufRange.lowerBound)
                    sourceString = "from \(result)"
                }
            }
        
         self.createTime = self.calcCreateAtString(date: status?.created_at)
            
        }
    
    }
    //MARK: - dealWithCreateTime
    
    private func calcCreateAtString(date: Date?) -> String?{
        
        //dealwith value for nil createTime
        guard let createTime = date else{
            
            return nil
        }
        // create time format
        let formatter = DateFormatter()
        // get value for current time
        let currentDate = Date()
        // create the variable for judge wether is current day
        let calendar = NSCalendar.current
        //passing the value of year from the model is current year or not
        if isDateInThisYear(target: createTime){
            // wether is current day or not
            if calendar.isDateInToday(createTime){
                
                let result = currentDate.timeIntervalSince(createTime)
                print(result)
                
                if result < 60{
                   return "1 minutes ago"
                }else if result < 3600{
                   return "\(Int(result) / 60) minutes ago"
                }else{
                   return "\(Int(result) / 3600) hours ago"
                }
            // this time is yesterday
            }else if calendar.isDateInYesterday(createTime){
                
                formatter.dateFormat = "yesterday HH:mm"
                return formatter.string(from: createTime)
            }else{
                
                formatter.dateFormat = "MM-dd HH:mm"
                return formatter.string(from: createTime)
            }
        
        }else{
            // this time is not current year
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: createTime)
            
        }
        
    }
    
    // judge the whether is curentTime about year or not from modelstatus
    
    private func isDateInThisYear(target: Date) -> Bool{
        
            // get currentDate
            let currentDate = Date()
            // define target target time variable
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            // get target and currentTime Year
            let targetYear = formatter.string(from: target)
            let currentYear = formatter.string(from: currentDate)
        
        return targetYear == currentYear
    }
    
    
    // dealWith numbers of counts
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
