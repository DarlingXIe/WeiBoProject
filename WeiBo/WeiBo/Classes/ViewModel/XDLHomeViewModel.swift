//
//  XDLStatusViewModel.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLHomeViewModel: NSObject {

    // var statusArray: [XDLStatus]?
    
    var statusArray: [XDLStatusViewModel]?
    
    static let shareModel:XDLHomeViewModel = XDLHomeViewModel()
    
    
    func loadData(completion:@escaping (Bool)->()){
        
        let urlString = "https://api.weibo.com/2/statuses/public_timeline.json"
        
        let parameters = [
            
            "access_token" : XDLUserAccountViewModel.shareModel.access_token ?? ""
        ]
        
        XDLNetWorkTools.sharedTools.request(method: .Get, urlSting: urlString, parameters: parameters) { (response, error) in
            if response == nil && error != nil{
                print("-------\(error)")
                return
            }
            print("******\(response)")
            // the array of statuses with dict of array
            guard let dictArray = (response! as! [String : Any])["statuses"] as? [[String : Any]] else{
                
                return
            }
            print("*&*&*&*&*&*&*&*\(dictArray)")
            // change the array of stauses with dict to the model of XDLStatus array
            
            let modelArray = NSArray.yy_modelArray(with: XDLStatus.self, json: dictArray) as! [XDLStatus]
            
            print("*&*&*&*\(modelArray)")
            
            var tempArray = [XDLStatusViewModel]()
            
            for status in modelArray{
                
                let viewModel = XDLStatusViewModel()
                viewModel.status = status
                tempArray.append(viewModel)
            }
            
            //self.statusArray = modelArray
            
            self.statusArray = tempArray
            
            completion(true)
            
           // self.tableView.reloadData()
        }
        
    }

    
}
