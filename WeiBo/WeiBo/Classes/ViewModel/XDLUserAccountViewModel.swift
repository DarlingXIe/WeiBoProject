//
//  XDLUserAccountViewModel.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLUserAccountViewModel: NSObject {
    
    var countModel: XDLUserAccount?
    
    static let shareModel:XDLUserAccountViewModel = XDLUserAccountViewModel()
    
    
    var access_token : String?{
    
        return countModel?.access_token
    }
    
    var userlogin:Bool {
        
        if countModel?.access_token != nil && isExpires == false{
        return true
        
        }
        return false
    }
    
    var isExpires: Bool{
        
        if let expireData = countModel?.expiresDate{
            if expireData.compare(Date()) == .orderedDescending{
            return false
            }
        }
          return true
    }
    
    override init(){
        
        super.init()
        
        countModel = self.loadAccount()
        
       // print("countModel")
    }
    
    // MARK: - 2. get AccessToken
    /*
     https://api.weibo.com/oauth2/access_token
     
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     
     */
    func loadAccessToken(code: String, completion:@escaping (Bool)->())
    {
        let urlSting = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = [
        
            "client_id": WB_APPKEY,
            "client_secret": WB_SECRET,
            "grant_type" : "authorization_code",
            "code": code,
            "redirect_uri" : WB_REDIRECT_URI
        ]
        
        XDLNetWorkTools.sharedTools.request(method: .Post, urlSting: urlSting, parameters: parameters) { (response, error) in
            if response == nil && error != nil{
                print("requestError!\(error)")
                completion(false)
                return
            }
            
            let countModel = XDLUserAccount(dict: response as! [String : Any])
           
            print("-----\(response)")
            
            self.loadUserInfo(userAccount: countModel, completion: completion)
            
        }
        
    }
    
    func loadUserInfo(userAccount : XDLUserAccount, completion:@escaping (Bool)->())
    {
        /*
         access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
         uid	false	int64	需要查询的用户ID。
         screen_name	false	string	需要查询的用户昵称。
         */
        
        let urlStirng = "https://api.weibo.com/2/users/show.json"
        
        let patameters = [
            
            "access_token" : (userAccount.access_token ?? ""),
            "uid": (userAccount.uid ?? ""),
        ]
        
        XDLNetWorkTools.sharedTools.request(method: .Get, urlSting: urlStirng, parameters: patameters) { (response, error) in
            
            if response == nil && error != nil{
                print("requestError!\(error)")
                completion(false)
                return
            }
            
            let dict = response as! [String : Any]
            
            userAccount.name = dict["name"] as? String
            
            userAccount.profile_image_url = dict["profile_image_url"] as? String
            
            self.saveAccount(account: userAccount)
            
            self.countModel = userAccount
            
            print("------\(userAccount)")
            
            completion(true)
        }
        
    }

   private func saveAccount(account:XDLUserAccount)
    {
        let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        
        NSKeyedArchiver.archiveRootObject(account, toFile: file)
    
    }
    
    private func loadAccount() -> XDLUserAccount? {
    
        let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        
       return NSKeyedUnarchiver.unarchiveObject(withFile: file) as? XDLUserAccount
    
    }
    
}
