//
//  XDLComposeToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

enum ComposeToolBarButtonType: Int {
 
    case picture = 0, mention, trend, emotion,add
    
}
class XDLComposeToolBar: UIView {

    var clickButtonClosure: ((ComposeToolBarButtonType)->())?
    
    var isSystemKeyBorad: Bool = true{
            didSet{
                
                let button = self.viewWithTag(3) as! UIButton
                
                var imageNamed = "compose_keyboardbutton_background"
                
                if isSystemKeyBorad {
                    
                    imageNamed = "compose_emoticonbutton_background"
                    
                }
                button.setImage(UIImage(named:imageNamed), for: .normal)
                button.setImage(UIImage(named:"\(imageNamed)_highlighted"), for: .highlighted)
        }
   }
    
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "compose_toolbar_background"))
        
        addSubview(stackView)
        
        stackView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(self)
            
        }
        
        addChildButtons(image: "compose_toolbar_picture", type: .picture)
        addChildButtons(image: "compose_mentionbutton_background", type: .mention)
        addChildButtons(image: "compose_trendbutton_background", type: .trend)
        addChildButtons(image: "compose_emoticonbutton_background", type: .emotion)
        addChildButtons(image: "compose_add_background", type: .add)
    
    }
    
    private func addChildButtons(image: String, type: ComposeToolBarButtonType){
        
        let button = UIButton()
        button.tag = type.rawValue
        button.addTarget(self, action: #selector(clickButtonType(button:)), for: .touchUpInside)
        button.setImage(UIImage(named: image), for: .normal)
        button.setImage(UIImage(named:"\(image)_highlighted"), for: .highlighted)
        stackView.addArrangedSubview(button)
    }
    
    
    @objc private func clickButtonType(button:UIButton){
        
        let type = ComposeToolBarButtonType(rawValue: button.tag)
        clickButtonClosure?(type!)
    }
    
    private lazy var stackView :UIStackView = {()-> UIStackView in
        
        let v = UIStackView()
        
        v.distribution = .fillEqually
        
        return v
    }()

    
}
