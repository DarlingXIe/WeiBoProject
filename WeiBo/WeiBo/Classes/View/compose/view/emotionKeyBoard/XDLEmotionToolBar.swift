//
//  XDLEmotionToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

/// 表情的类型
///
/// - RECENT:  最近
/// - DEFAULT: 默认
/// - EMOJI:   emoji
/// - LXH:     浪小花
import UIKit

enum XDLEmotionType:Int{
    
    case RECENT = 0, DEFAULT, EMOJI, LXH
    
}

class XDLEmotionToolBar: UIView {
    
    
    var currentSelectedButton: UIButton?
    
    var selectedIndexPath: IndexPath? {
        
        didSet{
            
            let button = self.stackView.viewWithTag((selectedIndexPath?.section)!)! as! UIButton
            
            if currentSelectedButton == button{
                return
            }
            currentSelectedButton?.isSelected = false
            
            button.isSelected = true
            
            currentSelectedButton = button
        }
    }
    
    var emotionTypeChangedClosure: ((XDLEmotionType) ->())?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor.white
        addSubview(stackView)
        
        stackView.snp_updateConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        addChildButton(title: "Recent", bgImgNamed: "compose_emotion_table_left" , type: .RECENT)
        addChildButton(title: "Default", bgImgNamed: "compose_emotion_table_mid", type: .DEFAULT)
        addChildButton(title: "Emoji", bgImgNamed: "compose_emotion_table_mid", type: .EMOJI)
        addChildButton(title: "Little Spray", bgImgNamed: "compose_emotion_table_right", type: .LXH)
    }
    
    private func addChildButton(title:String, bgImgNamed:String, type: XDLEmotionType)
    {
        let button = UIButton()
        
        //add target func for each button to excute closure
        button.addTarget(self, action: #selector(clickChildButton(button:)), for: .touchUpInside)
        
        button.tag = type.rawValue
        
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.setTitleColor(UIColor.gray, for: .selected)
        
        button.setBackgroundImage(UIImage(named:"\(bgImgNamed)_normal"), for: .normal)
        
        button.setBackgroundImage(UIImage(named:"\(bgImgNamed)_highlighted"), for: .selected)
        
        stackView.addArrangedSubview(button)
    
    }
    
    @objc private func clickChildButton(button:UIButton){
        
        if currentSelectedButton == button{
             return
        }
        currentSelectedButton?.isSelected = false
        
        button.isSelected = true
        
        currentSelectedButton = button
        
        let type = XDLEmotionType(rawValue:button.tag)
        
        emotionTypeChangedClosure?(type!)
    
    }
    
    
    
    private lazy var stackView :UIStackView = {()-> UIStackView in
        
         let stackView = UIStackView()
        
         stackView.tag = 1000
        
         stackView.distribution = .fillEqually
        
         return stackView
    }()


}
