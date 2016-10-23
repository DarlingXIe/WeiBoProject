//
//  XDLQRToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

enum XDLQRToolBarButtonType: Int {
    
    case SQCode = 0, SQLongCode
}

class XDLQRToolBar: UIView {
    
    var clickSQClosure: ((XDLQRToolBarButtonType)->())?
    
    var buttonArray: [UIButton]?//    var isSystemKeyBorad: Bool = true{
//        didSet{
//            
//            let button = self.viewWithTag(3) as! UIButton
//            
//            var imageNamed = "compose_keyboardbutton_background"
//            
//            if isSystemKeyBorad {
//                
//                imageNamed = "compose_emoticonbutton_background"
//                
//            }
//            button.setImage(UIImage(named:imageNamed), for: .normal)
//            button.setImage(UIImage(named:"\(imageNamed)_highlighted"),      for: .highlighted)
//        }
//    }
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor.darkGray
        
        addSubview(stackView)
        
        stackView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(self)
            
        }
        
        addChildButtons(image: "qrcode_tabbar_icon_qrcode", title: "QRCode",type: .SQCode)
        addChildButtons(image: "qrcode_tabbar_icon_barcode", title: "BarCode",type: .SQLongCode)
        
           }
    
    private func addChildButtons(image: String, title: String, type:XDLQRToolBarButtonType ){
        
        let button = UIButton()
        button.tag = type.rawValue
        
        button.addTarget(self, action: #selector(clickButtonType(button:)), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(red: 255/255.0, green: 120/255.0, blue: 0, alpha: 1), for: .highlighted)
        button.setImage(UIImage(named: image), for: .normal)
        button.setImage(UIImage(named:"\(image)_highlighted"), for: .highlighted)
        stackView.addArrangedSubview(button)
        buttonArray?.append(button)
        if button.tag == 0{
            button.isSelected = true
            button.setImage(UIImage(named:"\(image)_highlighted"), for: .selected)
            button.setTitleColor(UIColor(red: 255/255.0, green: 120/255.0, blue: 0, alpha: 1), for: .selected)
        }
    }

    @objc private func clickButtonType(button:UIButton){
        
        let type = XDLQRToolBarButtonType(rawValue: button.tag)
        if button.tag == 0 {
            //buttonArray?[0].isSelected = false
            button.isSelected = false
        }else{
            buttonArray?[0].isSelected = false
            buttonArray?[0].setImage(UIImage(named: "qrcode_tabbar_icon_qrcode"), for: .normal)
            buttonArray?[0].setImage(UIImage(named:"\("qrcode_tabbar_icon_qrcode")_highlighted"), for: .highlighted)
            layoutIfNeeded()
        }
        
        clickSQClosure?(type!)
    }
    
    private lazy var stackView :UIStackView = {()-> UIStackView in
        
        let v = UIStackView()
        
        v.distribution = .fillEqually
    
        return v
    }()


}
