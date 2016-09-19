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

}








