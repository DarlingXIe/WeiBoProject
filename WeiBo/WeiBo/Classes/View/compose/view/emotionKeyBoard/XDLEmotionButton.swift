//
//  XDLEmotionButton.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLEmotionButton: UIButton {
    
    var emotions : XDLEmotion?{
        
        didSet{
            
            if emotions!.type == 0{
            
                let bundle = XDLEmotionViewModel.sharedViewModel.emotionBundle
                let image = UIImage(named: "\(emotions!.path!)/\(emotions!.png!)", in: bundle, compatibleWith: nil)
                self.setImage(image, for: .normal)
                self.setTitle(nil, for: .normal)
        
            }else{
                
                self.setTitle((emotions!.code! as NSString).emoji(), for: .normal)
                self.setImage(nil, for: .normal)
                
            }
        }
    }
}
