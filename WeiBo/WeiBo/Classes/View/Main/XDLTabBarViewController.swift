//
//  XDLTabBarViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        
        
        
        addChildViewController()
       
    
    }
    
    func addChildViewController(){
    
        addChildViewController(vc:XDLHomeViewController() , title: "首页", imageName:"tabbar_home")
        addChildViewController(vc:XDLMessageViewController() , title: "消息", imageName: "tabbar_message_center")
        addChildViewController(vc:XDLDiscoverViewController() , title: "发现", imageName: "tabbar_discover")
        addChildViewController(vc:XDLProfileViewController(), title: "我", imageName:"tabbar_profile")
        
    
    }
    
    func addChildViewController(vc:UIViewController, title: String, imageName: String)
    {
        
        vc.title = title
        
        vc.tabBarItem.image = UIImage(named: imageName)
        
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: UIControlState.selected)
        
        let navVc = XDLNavigationViewController(rootViewController: vc)
        
        addChildViewController(navVc)
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
