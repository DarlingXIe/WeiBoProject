//
//  SQLiteManager.swift
//  MySQLite
//
//  Created by DalinXie on 16/10/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import FMDB

private let dbname = "status.db"

class SQLiteManager: NSObject {
    
    static let shared = SQLiteManager()
    
    var queue: FMDatabaseQueue?
    
    override init() {
        
        super.init()
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathExtension(dbname)
        
        print("create the my SQLite: \(path)")
        
        queue = FMDatabaseQueue(path:path)
    
        createTable()
        
    }
    
    private func createTable(){
        
        let pathURL = Bundle.main.url(forResource: "db.sql", withExtension: nil)!
        
        let sql = try! String(contentsOf: pathURL)
        
        print(sql)
        
        queue?.inDatabase({ (db) in
            let result = db!.executeStatements(sql)
            if result{
                print("success")
            }else{
                print("failed")
            }
        })
    }
    
       func execRecordSet(sql: String) ->[[String: Any]]{
    
        var result = [[String : Any]]()
        
        queue?.inDatabase({ (db) in
           
            let resultSet = db!.executeQuery(sql, withArgumentsIn: nil)!
            
            while resultSet.next(){
                
                var dict = [String:Any]()
                
                let colCount = resultSet.columnCount()
                
                for i in 0..<colCount{
                    
                    let colName = resultSet.columnName(for: i)!
                    
                    let colValue = resultSet.object(forColumnIndex: i)
                    
                    dict[colName] = colValue
                
                }
                result.append(dict)
            }
        })
        
        return result
    }
}
