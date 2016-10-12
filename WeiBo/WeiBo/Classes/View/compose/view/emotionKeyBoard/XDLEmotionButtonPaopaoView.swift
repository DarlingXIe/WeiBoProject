//
//  XDLEmotionButtonPaopaoView.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLEmotionButtonPaopaoView: UIView {

    @IBOutlet weak var XDLEmotionButton: XDLEmotionButton!
    
    class func paopaoView() -> XDLEmotionButtonPaopaoView{
        
        let result = Bundle.main.loadNibNamed("XDLEmotionPaopaoView", owner: nil, options: nil)!.last! as! XDLEmotionButtonPaopaoView
        
        return result
    
    }

}
