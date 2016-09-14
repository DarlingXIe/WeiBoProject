//
//  UIView+ ConvenienceExtension.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UILabel{
    
    convenience init(textColor: UIColor, fontSize: CGFloat)
    {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}

extension UIButton{
    
    convenience init(textColor: UIColor, fontSize: CGFloat) {
        self.init()
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
}
