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
        
        composeButton.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.5)
        
        let itemW = self.bounds.size.width/5
        
        var index = 0
        
        for subView in self.subviews{
        
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                
                let itemX = CGFloat(index) * itemW
                
                subView.frame.size.width = itemW
                
                subView.frame.origin.x = itemX
              
                index = index + 1
                
                if index == 2{
                
                    index = index+1
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
