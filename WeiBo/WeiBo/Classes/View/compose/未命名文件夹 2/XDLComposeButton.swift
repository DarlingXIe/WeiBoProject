//
//  XDLComposeButton.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLComposeButton: UIButton {

    override var isHighlighted: Bool {
        set {
            
        }
        get {
            return false
        }
    }
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
        
    }
    
        required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI for button with imageView and label
    private func setupUI(){
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .center
    }
    
    //MARK: - layout imageView and titleLabel with frame
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        imageView?.frame = CGRect(x: 0, y: 0, width: width, height: width)
        titleLabel?.frame = CGRect(x: 0, y: width, width: width, height: height - width)
        
    }

}
