//
//  XDLStatusViewModel.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

import SDWebImage

class XDLHomeViewModel: NSObject {

    // var statusArray: [XDLStatus]?
    
    var statusArray: [XDLStatusViewModel]?
    
    static let shareModel:XDLHomeViewModel = XDLHomeViewModel()
    
    
    func loadData(completion:@escaping (Bool)->()){
        
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        
        let parameters = [
            
            "access_token" : XDLUserAccountViewModel.shareModel.access_token ?? " "
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
                //print---oriPictureWithText..
                if let pic_urls = status.pic_urls, pic_urls.count > 0 {
                    print(status.pic_urls?.first?.thumbnail_pic)
                }
                
                let viewModel = XDLStatusViewModel()
                viewModel.status = status
                tempArray.append(viewModel)
            }
            
            //self.statusArray = modelArray
            
            self.statusArray = tempArray
            
            
            //completion(true)
            
           // self.tableView.reloadData()
            
           //download the singlePic for origView
            self.cacheSingleImage(status: tempArray, completion: completion)
            
        }
        
    }

    private func cacheSingleImage(status:[XDLStatusViewModel], completion:@escaping (Bool)->()){
        // group to download images when it's completed, recall the block for inform controller 
        let group = DispatchGroup.init()
        
        for piValue in status{
            
            guard let pic_urls = (piValue.status?.pic_urls?.count == 1) ? piValue.status?.pic_urls : piValue.status?.retweeted_status?.pic_urls, pic_urls.count == 1 else{
                continue
            }
            
            let photoInfo = pic_urls.first!
            
            let urlString = photoInfo.thumbnail_pic
            
            let url = URL(string: urlString ?? "")
            
            group.enter()
            
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, error, _, _, _) in
                
                photoInfo.size = image?.size
                
                print("download completed:")
                
                group.leave()
                
            })
            
            group.notify(queue: DispatchQueue.main, execute: { 
                print("download all pics")
                completion(true)
            })
        }
        
    }
    
    
}
