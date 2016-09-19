//
//  XDLOAutoViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD

 let WB_APPKEY = "952701227"
 let WB_SECRET = "ddd422359bcb972236c6f9663ee720a7"
 let WB_REDIRECT_URI = "http://www.itheima.com/"
 //let WB_LANGUAGE = "en"
class XDLOAuthViewController: UIViewController, UIWebViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    private func setupUI(){
    
       view.backgroundColor = UIColor.white
       
       title = "WeiBo Login"

       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", target: self, action:#selector(close))
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AutoFill", target: self, action:#selector(AutoFill))
        
      self.view.addSubview(webView)
        
     
      webView.snp_makeConstraints { (make) in
        
        make.edges.equalTo(self.view)
        
        }
        
       let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APPKEY)&redirect_uri=\(WB_REDIRECT_URI)"
        
       let url = URL(string: urlString)!
       
       let request = URLRequest(url: url)
       
       webView.loadRequest(request)
        
    }
    
   // MARK: - lazy load webView
   private lazy var webView :UIWebView = {()-> UIWebView in
        
        let webView = UIWebView()
        webView.delegate = self
        return webView
    
    }()

    @objc private func close(){
    
        dismiss(animated: true, completion: nil);

    }
    
    // MARK: - AutoFill to information
    
    @objc private func AutoFill(){
        //MARK: - AutoFill for userAccount and passWorld
        let urlSting = "document.getElementById('userId').value ='xdltmac@sina.com'; document.getElementById('passwd').value = 'Xdl@891221';"
        
        webView.stringByEvaluatingJavaScript(from: urlSting)
        
    }
    
    // MARK: - 1. getCodeNumber---WebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request:  URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url{
            
            let urlString = url.absoluteString
            
            if !urlString.hasPrefix(WB_REDIRECT_URI){
                return true
            }
        }
        
        if let query = request.url?.query{
            let code = query.substring(from: "code=".endIndex);
            print("------\(code)")
            XDLUserAccountViewModel.shareModel.loadAccessToken(code: code, completion: { (isSuccess) in
                if isSuccess{
                    //swich to other UI
                    print("switch to welcomePage")
                   NotificationCenter.default.post(name: NSNotification.Name(XDLChangeRootController), object: self)
                    
                }else{
                    print("failed to login")
                }
            })
        }
        
        return false
        
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
    
    /*    func loadAccessToken(code: String)
    {
        let urlSting = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = [
            
            "client_id": WB_APPKEY,
            "client_secret": WB_SECRET,
            "grant_type" : "authorization_code",
            "code": code,
            "redirect_uri" : WB_REDIRECT_URL
        ]
   
     
        XDLNetWorkTools.sharedTools.request(method: .Post, urlSting: urlSting, parameters: parameters) { (response, error) in
            if error != nil && response == nil{
                print("requestError!\(error)")
                return
            }
            let countmodel = XDLUserAccount(dict: response as! [String : Any])
            self.loadUserInfo(userAccount: countmodel)
            }

    }
    
    func loadUserInfo(userAccount : XDLUserAccount)
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
                return
            }
           
            let dict = response as! [String : Any]
            
            userAccount.name = dict["name"] as? String
            
            userAccount.profile_image_url = dict["profile_image_url"] as? String
            
        }
        
    }
    */
    func webViewDidStartLoad(_ webView: UIWebView) {
        // show something to indicator
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
