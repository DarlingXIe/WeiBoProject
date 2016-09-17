//
//  XDLOAutoViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD


private let WB_APPKEY = "952701227"
private let WB_SECRET = "ddd422359bcb972236c6f9663ee720a7"
private let WB_REDIRECT_URL = "http://www.itheima.com/"
private let WB_LANGUAGE = "en"
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
        
       let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APPKEY)&redirect_uri=\(WB_REDIRECT_URL)&language%20=%20en"
        
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
    
    // MARK: - WebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request:  URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let url = request.url{
            
            let urlString = url.absoluteString
            
            if !urlString.hasPrefix(WB_REDIRECT_URL){
                return true
            }
        }
        
        if let query = request.url?.query{
            let code = query.substring(from: "code=".endIndex);
            print(code)
        }
        
        return false
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
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
