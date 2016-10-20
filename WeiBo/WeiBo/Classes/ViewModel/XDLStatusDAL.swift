//
//  XDLStatusDAL.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

private let cacheMaxTimeInterval: TimeInterval = -7 * 24 * 60 * 60

class XDLStatusDAL: NSObject {
    
    class func loadData(maxId: Int64, sinceId: Int64, completion:@escaping ([[String: Any]]?)->()){
        
        // 1. DataFromDataBase
        let result = checkData(maxId: maxId, sinceId: sinceId)
        // 2. to judge whether result has value or not
        if result.count > 0{
            completion(result)
            return
        }
        // 3. if result has no value, downloadfromInternet
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        
        let params = [
            "max_id": "\(maxId)",
            "since_id": "\(sinceId)",
            "access_token": XDLUserAccountViewModel.shareModel.access_token ?? " "
        ]
        
        XDLNetWorkTools.sharedTools.request(method: .Get, urlSting: urlString, parameters: params) { (response, error) in
            if error != nil {
                print("请求错误\(error)")
                completion(nil)
                return
            }
            guard let dictArray = (response! as! [String: Any])["statuses"] as? [[String: Any]] else {
                return
            }
            // 4.
            XDLStatusDAL.loadDataIntoTable(status: dictArray)
        
            completion(dictArray)
        }
    }
    
    class func checkData(maxId: Int64, sinceId: Int64) -> [[String: Any]] {
        
        var sql = "SELECT statusid, status, uid FROM T_Status\n"
        
        if maxId > 0{
            sql += "WHERE statusid <=\(maxId)\n"
        }else{
            sql += "WHERE statusid > \(sinceId)\n"
        }
        
        sql += "ORDER BY statusid DESC\n"
        
        sql += "LIMIT 20"
        
        let sqlResult = SQLiteManager.shared.execRecordSet(sql: sql)
        
        var result = [[String : Any]]()
    
        for value in sqlResult{
            
            let data = value["status"]! as! Data
            
            let dict = try! JSONSerialization.jsonObject(with: data, options: [])
            
            result.append(dict as! [String : Any])
        }
        return result
    }
    
    //MARK: -4.loadDataFromInternet
    
    class func loadDataIntoTable(status:[[String: Any]]){
        
        guard let uid = XDLUserAccountViewModel.shareModel.countModel?.uid
           else{
            print("uid is nill")
            return
        }
        
        let sql = "INSERT INTO T_Status (statusid, status, uid) VALUES (?,?,?);"

        SQLiteManager.shared.queue?.inTransaction({ (db, rollBack) in
            
            for value in status{
                
                let statusid = value["id"]!
                
                let status = try! JSONSerialization.data(withJSONObject: value, options: [])
                
                let result = db!.executeUpdate(sql, withArgumentsIn: [statusid,status, uid])
                
                if result == false{
                    rollBack?.pointee = true
                    break
               }
            }
        })
    }
    
}
