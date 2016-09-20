//
//  XDLRetweetStatusView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLRetweetStatusView: UIView {
    
    var statusViewModel:XDLStatusViewModel?{
       /**/
        didSet{
            
           retweetContentLabel.text = statusViewModel?.status?.retweeted_status?.text
            
            }
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
       // backgroundColor = UIColor.gray
        
        addSubview(retweetContentLabel)
        
        retweetContentLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(self).offset(XDLStatusCellMargin)
            make.bottom.equalTo(self).offset(-XDLStatusCellMargin)
            
        }
    }

    private lazy var retweetContentLabel:UILabel = {()-> UILabel in
        
        let contentLabel = UILabel(textColor: UIColor.darkGray, fontSize: 15)
        
        contentLabel.numberOfLines = 0
        
        contentLabel.preferredMaxLayoutWidth = XDLScreenW - 2*XDLStatusCellMargin
        
        return contentLabel
        
    }()


}
