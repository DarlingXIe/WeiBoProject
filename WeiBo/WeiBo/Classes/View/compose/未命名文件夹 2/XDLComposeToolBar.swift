//
//  XDLComposeToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

enum composeToolBarButtonType: Int {

    case picture = 0, mention, trend, emotion, add
    
}

class XDLComposeToolBar: UIView {

    //MARK: - define closure
    var clickbuttonclosure: ( (_ toolBar: XDLComposeToolBar,_ type:composeToolBarButtonType) ->())?
    
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
        
        addChildButtons(imageName: "compose_toolbar_picture",type: .picture)
        addChildButtons(imageName: "compose_mentionbutton_background", type: .mention)
        addChildButtons(imageName: "compose_trendbutton_background", type: .trend)
        addChildButtons(imageName: "compose_emoticonbutton_background", type: .emotion)
        addChildButtons(imageName: "compose_add_background", type: .add)
    }
    
    private func addChildButtons(imageName: String, type: composeToolBarButtonType){
        
        let button = UIButton()
        button.tag = type.rawValue
        button.setImage(UIImage(named:imageName), for: .normal)
        button.setImage(UIImage(named:"\(imageName)_highlighted"), for: .highlighted)
        //MARK: -
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    private lazy var stackView :UIStackView = {()-> UIStackView in
        
        let stackView = UIStackView()
        
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    @objc private func clickButton(button: UIButton){
        
        let type = composeToolBarButtonType(rawValue: button.tag)!
        clickbuttonclosure?(self, type)
        
    }
    
    
}
