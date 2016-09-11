//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//
import UIKit

extension UIBarButtonItem{

    convenience init(imgName : String? = nil, title: String? = nil, target: Any?, action: Selector?) {
        
        self.init()
        
        let button = UIButton()
        
        if let img = imgName{
        
            button.setImage(UIImage(named:img), for: .normal)
            
            button.setImage(UIImage(named:"\(img)_highlighted"), for: .highlighted)
        }
        
        if let t = title{
        
            button.setTitle(t, for:.normal)
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            button.setTitleColor(UIColor.gray, for: .normal)
            
            button.setTitleColor(UIColor.orange, for:.highlighted)
            
        
        }
        if let act = action{
        
            button.addTarget(target, action: act, for: .touchUpInside)
            
        }
        
         button.sizeToFit()
        
         self.customView = button
    
    }

}
