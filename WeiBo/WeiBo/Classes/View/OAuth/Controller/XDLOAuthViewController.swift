//
//  XDLOAutoViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLOAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    private func setupUI(){
    
       view.backgroundColor = UIColor.white
       
       title = "WeiBo Login"

       navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", target: self, action:#selector(close))
    
    }
    
    @objc private func close(){
    
        dismiss(animated: true, completion: nil);

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
