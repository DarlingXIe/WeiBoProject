//
//  XDLMatchResult.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLMatchResult: NSObject {
    
    var captureString: String
    
    var captureRange: NSRange
    
    init(string: String, range: NSRange){
        
        captureString = string
        
        captureRange = range
    }

}
