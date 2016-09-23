//
//  XDLRetweetStatusView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLRetweetStatusView: UIView {
    
    
    
    var bottomCons : Constraint?
    
    var statusViewModel:XDLStatusViewModel?{
       /**/
        didSet{
            
           retweetContentLabel.text = statusViewModel?.status?.retweeted_status?.text
            
            self.bottomCons?.uninstall()
            
            if let url_picture = statusViewModel?.status?.pic_urls, url_picture.count > 0{
            
                pictureView.isHidden = false
                
                self.snp_updateConstraints(closure: { (make) in
                 self.bottomCons = make.bottom.equalTo(pictureView.snp_bottom).offset(-XDLStatusCellMargin).constraint
                })
                
            }else{
               pictureView.isHidden = true
               self.snp_updateConstraints{ (make) in
               self.bottomCons = make.bottom.equalTo(retweetContentLabel.snp_bottom).offset(-XDLStatusCellMargin).constraint
                }
            }
            
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
        
            addSubview(pictureView)
        
        retweetContentLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(self).offset(XDLStatusCellMargin)
           // make.bottom.equalTo(self).offset(-XDLStatusCellMargin)
            
        }
        
       pictureView.snp_makeConstraints { (make) in
        
           make.top.equalTo(retweetContentLabel.snp_bottom).offset(XDLStatusCellMargin)
           make.size.equalTo(CGSize(width: 100, height: 200))
           make.left.equalTo(retweetContentLabel)
           //make.bottom.equalTo(self).offset(-XDLStatusCellMargin)
        }
        
        self.snp_makeConstraints { (make) in
          self.bottomCons = make.bottom.equalTo(pictureView).offset(-XDLStatusCellMargin).constraint
       }
    
    }

    private lazy var retweetContentLabel:UILabel = {()-> UILabel in
        
        let contentLabel = UILabel(textColor: UIColor.darkGray, fontSize: 15)
        
        contentLabel.numberOfLines = 0
        
        contentLabel.preferredMaxLayoutWidth = XDLScreenW - 2*XDLStatusCellMargin
        
        return contentLabel
        
    }()

   private lazy var pictureView :XDLStatusPictureView = {()-> XDLStatusPictureView in
        
    let pictureView = XDLStatusPictureView(frame: CGRect.zero, collectionViewLayout:UICollectionViewFlowLayout())
    
    return pictureView
    
    }()


}
