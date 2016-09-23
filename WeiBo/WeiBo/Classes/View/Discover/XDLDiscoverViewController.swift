//
//  XDLDiscoverViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLDiscoverViewController: XDLVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if userlogin == false{
    
        self.visitorView.visitorImageInfo(imageName: "visitordiscover_image_message", messageTitle: "NO INTERNET SERVICE")
        
            return
        }
        
        setupUI()
    
    }
    private func setupUI(){
    
        let searchView = XDLDiscoverSearchView.searchView()
        
        searchView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30)
        
        navigationItem.titleView = searchView
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
