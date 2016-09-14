//
//  XDLVisitorView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLVisitorView: UIView {
    
    var delegateClosure:(()->())?
    
    override init(frame: CGRect){
    
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor(white: 237/255, alpha: 1)
        
        addSubview(iconView)
        addSubview(circleView)
        addSubview(maskIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        
        iconView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        circleView.snp_makeConstraints { (make) in
            make.center.equalTo(iconView)
        }
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(circleView.snp_bottom).offset(16)
            make.width.equalTo(224)
        }
    
        registerButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.left.equalTo(messageLabel)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }

        loginButton.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(messageLabel)
            make.top.equalTo(registerButton)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        
        maskIconView.snp_makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.bottom.equalTo(registerButton)
        }

       
    }
    
    func startAnimation(){
        
            let anim = CABasicAnimation(keyPath: "transform.rotation")
        
            anim.toValue = M_PI * 2
        
            anim.repeatCount = MAXFLOAT
        
            anim.duration = 20
        
            anim.isRemovedOnCompletion = false
        
            circleView.layer.add(anim, forKey: nil)
    
        
    }
    // MARK: - whether is imageName or not
    
    func visitorImageInfo(imageName: String? , messageTitle: String?)
    {
        if imageName != nil{
        
            circleView.isHidden = true
            iconView.image = UIImage(named: imageName!)
            messageLabel.text = messageTitle
        }else{
            messageLabel.text = messageTitle
        }
            startAnimation()
    }
    
    
    // MARK: - create subviews on VisitorView
    
   private lazy var iconView : UIImageView = {
        
    let image = UIImageView(image:#imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
        return image
    }()

    private lazy var circleView :UIImageView = {()-> UIImageView in
        
        let image = UIImageView(image:#imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
    
        return image
    }()
 
    lazy var maskIconView :UIImageView = {()-> UIImageView in
        
        let image = UIImageView(image:#imageLiteral(resourceName: "visitordiscover_feed_mask_smallicon"))

        return image
    }()

    private lazy var messageLabel :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.darkGray, fontSize: 14)
    
        label.numberOfLines = 0
        
        label.textAlignment = .center
        
        return label
    }()

    private lazy var registerButton :UIButton = {()-> UIButton in
        
        let button = UIButton(textColor: UIColor.darkGray, fontSize: 14)

        button.setTitle("注册", for:.normal)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_white"), for: .normal)
        
        return button
        
    }()

    private lazy var loginButton :UIButton = {()-> UIButton in
        
        let button = UIButton(textColor: UIColor.darkGray, fontSize: 14)
        
        button.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
        button.setTitle("登录", for:.normal)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_white"), for: .normal)
        
        return button
    }()

    @objc private func loginButtonClick(){
        
        print("登录")
        
        delegateClosure?()
        
    }
    
}
