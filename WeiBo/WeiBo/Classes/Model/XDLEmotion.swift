//
//  XDLEmotion.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

import YYModel

class XDLEmotion: NSObject, NSCoding{
    
        var chs: String?
    
        var cht: String?
    
        var png: String?
    
        var type: Int = 0
    
        var code: String?
    
        var path: String?
    
    override init(){
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        self.yy_modelEncode(with: aCoder)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.yy_modelInit(with: aDecoder)
    }

}
