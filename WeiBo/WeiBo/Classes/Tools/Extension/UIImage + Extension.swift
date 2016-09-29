//
//  UIImage + Extension.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/29.
//  Copyright © 2016年 itcast. All rights reserved.
//
// get the snapScreen from UIImageExtension
import UIKit

extension UIImage{
    
    //MARK: - make screenSnap
    class func getScreenSnap() -> UIImage?{
        
        //capture the window
        let window = UIApplication.shared.keyWindow
        //beginImageContext with window size
        UIGraphicsBeginImageContextWithOptions(window!.bounds.size, false, 0)
        //draw context with window with beginImageContextSize
        window?.drawHierarchy(in: window!.bounds, afterScreenUpdates: false)
        //capture the image from the windowContext
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //end context
        UIGraphicsEndImageContext()
        //reture image
        return image
    }

}
