//
//  UIView+IBExtension.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//
import UIKit


extension UIView{

    @IBInspectable var cornerRadius: CGFloat{
    
        set{
             layer.cornerRadius = newValue
             layer.masksToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }

    }
}
