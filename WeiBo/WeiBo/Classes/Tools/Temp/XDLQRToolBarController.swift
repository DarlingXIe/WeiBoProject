//
//  XDLTempViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit


class XDLQRToolBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI(){
    
        title = "The\(navigationController?.childViewControllers.count)controller"
        
        self.view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imgName: "compose_toolbar_picture", title: "", target: self, action: #selector(pushTestVc))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_back", title: " ", target: self, action: #selector(backToPrevious))
        
        view.addSubview(SQToolBar)
        
        SQToolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(49)
        }
    
        self.SQToolBar.clickSQClosure = {[weak self](type:XDLQRToolBarButtonType) -> () in
            print("****clickComposeButtons\(self)")
            switch type {
            case .SQCode:
                print("SQCode")
            case .SQLongCode:
                print("SQLongCode")
            }
            
        }
    
    }
    
    
    //click navigationItemButton
    func pushTestVc(){
        
        print("Album")
        
    }
    //click navigationBackItemButton
    func backToPrevious(){
     _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - lazy var UI
   internal lazy var SQToolBar :XDLQRToolBar = {()-> XDLQRToolBar in
        
        let SQToolBar = XDLQRToolBar()
        
        //label.textColor = UIcolor.red
        
        return SQToolBar
    }()

    
}
