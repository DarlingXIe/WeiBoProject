
//
//  XDLStatusToolBar.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLStatusToolBar: UIView {
    
    var retweetButton: UIButton!
    var commentButton: UIButton!
    var unlikeButton : UIButton!

    var statusViewModel: XDLStatusViewModel?{
        
        didSet{
        
            retweetButton.setTitle(statusViewModel?.reposts_count, for: .normal)
            
            commentButton.setTitle(statusViewModel?.comments_count, for: .normal)
            
            unlikeButton.setTitle(statusViewModel?.attitudes_count, for: .normal)
            
        }
    
    }
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        setupUI()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        // add button class
        retweetButton = addChildButton(imageName: "timeline_icon_retweet", defaultTile: "share")
        
        commentButton = addChildButton(imageName: "timeline_icon_comment", defaultTile: "comment")
        
        unlikeButton = addChildButton(imageName: "timeline_icon_unlike", defaultTile: "like")
        let sp1 = UIImageView(image: #imageLiteral(resourceName: "timeline_card_bottom_line"))
        let sp2 = UIImageView(image: #imageLiteral(resourceName: "timeline_card_bottom_line"))
        addSubview(sp1)
        addSubview(sp2)
        
        retweetButton.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(commentButton.snp_width)
        }

        commentButton.snp_makeConstraints { (make) in
            
            make.left.equalTo(retweetButton.snp_right)
            make.top.bottom.equalTo(retweetButton)
            make.width.equalTo(unlikeButton.snp_width)
        }
      
        unlikeButton.snp_makeConstraints { (make) in
            
            make.top.right.bottom.equalTo(self)
            make.left.equalTo(commentButton.snp_right)
            make.width.equalTo(retweetButton.snp_width)
            
        }
        
        sp1.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(retweetButton.snp_right)
            make.centerY.equalTo(retweetButton)
        }

        sp2.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(commentButton.snp_right)
            make.centerY.equalTo(commentButton)
        }

    }
    
    private func addChildButton(imageName: String, defaultTile: String) -> UIButton {
    
        let button = UIButton()
    button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: .normal)
    button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background_highlighted"), for: .highlighted)
        
        button.setImage(UIImage(named:imageName), for: .normal)
        
        button.setTitle(defaultTile, for: .normal)
        
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        addSubview(button)
        
        return button
    }
    
}
