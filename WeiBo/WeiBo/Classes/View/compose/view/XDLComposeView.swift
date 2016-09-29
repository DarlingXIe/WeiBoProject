//
//  XDLComposeView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLComposeView: UIView {

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor.black
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
