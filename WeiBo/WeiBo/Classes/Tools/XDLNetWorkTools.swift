//
//  XDLNetWorkTools.swift
//  SwiftAFNFrame
//
//  Created by DalinXie on 16/9/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import AFNetworking

// parameter Get request

// parameter Post request

enum HMHttpMethod: String {
    case Get = "GET"
    case Post = "POST"
}

class XDLNetWorkTools: AFHTTPSessionManager {

    static let sharedTools: XDLNetWorkTools = {
        
        let tools = XDLNetWorkTools()
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()

    func request(method:HMHttpMethod, urlSting: String, parameters: Any?, completion:@escaping (Any?, Error?)->()) {
        
        let successClosure:(URLSessionDataTask, Any?) ->() = {(_, responseData) in
        
          completion(responseData, nil)
        
        }
        
        let failureClosure:(URLSessionDataTask?, Error) ->() = {(_, error) in
            
            completion(nil, error)
            
        }
        
        if method == .Get {
            
            self.get(urlSting, parameters: parameters, progress: nil, success: successClosure, failure: failureClosure)
        }else{
            
            self.post(urlSting, parameters: parameters, progress: nil, success: successClosure, failure: failureClosure)
        }
    }
    // upload file with picture
    func requestUploadPost(method:HMHttpMethod, urlSting:String, params: Any?, fileDict: [String: Data], completion:@escaping (Any?, Error?)->()){
        
        let successClosure:(URLSessionDataTask, Any?) ->() = {(_, responseData) in
            
            completion(responseData, nil)
            
        }
        
        let failureClosure:(URLSessionDataTask?, Error) ->() = {(_, error) in
            
            completion(nil, error)
            
        }
        
        self.post(urlSting, parameters: params, constructingBodyWith: { (formData) in
            
            for(key, value) in fileDict{
                
                formData.appendPart(withFileData: value, name: key, fileName: "bbbb", mimeType: "application/octet-stream")
                
            }
            
            }, progress: nil, success: successClosure, failure: failureClosure)
    }

//    let urlSting = "https://upload.api.weibo.com/2/statuses/upload.json"
//    
//    let accessToken = XDLUserAccountViewModel.shareModel.access_token
//    
//    let params = [
//        
//        "access_token" : accessToken,
//        
//        "status" : textView.emotionText ?? ""
//        
//    ]
    
//        XDLNetWorkTools.sharedTools.post(urlSting, parameters: params, constructingBodyWith: { (formData) in
//    
//        let data = UIImagePNGRepresentation(self.pictureView.images.first!)!
//    
//        formData.appendPart(withFileData: data, name: "png", fileName: "bbbb", mimeType: "application/octet-stream")
//    
//        }, progress: nil, success: { (response, _) in
//    
//        print("request successed")
//        SVProgressHUD.showSuccess(withStatus: "upload success")
//    
//        }) { (_, error) in
//    
//        print("request failed")
//    
//        SVProgressHUD.showSuccess(withStatus: "upload failed")
//        }

}








