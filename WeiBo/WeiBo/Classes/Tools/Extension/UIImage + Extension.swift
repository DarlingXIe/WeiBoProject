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
    
    func scaleTo(width: CGFloat) -> UIImage{
        
        if self.size.width < width{
        
            return self
        }
        //100 200
        //50
        let height = self.size.height * (width / self.size.width)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        self.draw(in: rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
}
