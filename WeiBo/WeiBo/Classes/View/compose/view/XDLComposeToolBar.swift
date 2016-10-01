//
//  XDLComposeToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLComposeToolBar: UIView {

    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor.black
        
    
    }
    
}
