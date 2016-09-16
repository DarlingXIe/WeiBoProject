//
//  XDLMessageViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLMessageViewController: XDLVisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if userlogin == false{
            
            self.visitorView.visitorImageInfo(imageName: "visitordiscover_image_message", messageTitle: "NO INTERNET SERVICE")
            
            return
            
        }

        
        // Do any additional setup after loading the view.
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
