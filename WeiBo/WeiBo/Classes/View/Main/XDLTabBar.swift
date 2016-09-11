//
//  XDLTabBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLTabBar: UITabBar {
    //
    var composeButtonClosure:(()->())?
    
    override init(frame:CGRect){
    
    super.init(frame:frame)
    
    setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        backgroundImage = #imageLiteral(resourceName: "tabbar_background")
        
        addSubview(composeButton)

    }

    override func layoutSubviews() {
    
        super.layoutSubviews()
        
        //set composeButton Width
        
        composeButton.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
    
        //set index to change x of subviews
        var index = 0
        
        //calculate all subviews button's itemW
        let itemW = UIScreen.main.bounds.size.width/5
        
        //for in function--- to set postion of subviews
        for subview in self.subviews{
            
        //judge that the value of subview is "UITabBarButton"
        
            if subview.isKind(of: NSClassFromString("UITabBarButton")!){
                
                // according to index to calculate each button width
                let itemX = CGFloat(index) * itemW
                // update values of each button frame
                subview.frame.origin.x = itemX
                
                subview.frame.size.width = itemW
                
                // index +1
                
                index = index + 1
                
                if index == 2{
                    
                    index = index + 1
                    
                }
            
            }
            
        }
        
    }
    
    lazy var composeButton: UIButton = {
        
        let button = UIButton()

        button.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
        
        button.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        
        button.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for:.highlighted)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        button.sizeToFit()
        
        return button
    
    }()

    @objc private func composeButtonClick(){
        
         composeButtonClosure?()
        
    }
    
}
