//
//  XDLOriginalStatusView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLOriginalStatusView: UIView {
    
    var bottomCons : Constraint?
    
    var statusViewModel: XDLStatusViewModel?{
    
        didSet{
        
            iconView.sd_setImage(with: URL(string:statusViewModel?.status?.user?.profile_image_url ?? ""), placeholderImage: #imageLiteral(resourceName: "avatar_default"))
            
            nameLabel.text = statusViewModel?.status?.user?.name
            
            memberIconView.image = statusViewModel?.memberImage
            
            avatarView.image = statusViewModel?.avatarImage
            
            contentLabel.text = statusViewModel?.status?.text
        
            bottomCons?.uninstall()
            
            if let pic_urls = statusViewModel?.status?.pic_urls, pic_urls.count > 0 {
                
                pictureView.isHidden = false
                pictureView.pic_urls = pic_urls
                self.snp_updateConstraints(closure: { (make) in
                  self.bottomCons = make.bottom.equalTo(pictureView.snp_bottom).offset(XDLStatusCellMargin).constraint
                })
            
            }else{
                pictureView.isHidden = true
                self.snp_updateConstraints(closure: { (make) in
                  self.bottomCons = make.bottom.equalTo(contentLabel.snp_bottom).offset(XDLStatusCellMargin).constraint
                })
                
            }
    
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
    
    //MARK: - setupUI()
    
    private func setupUI(){
       
        backgroundColor = UIColor.white
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(createTime)
        addSubview(sourceLabel)
        addSubview(avatarView)
        addSubview(contentLabel)
        addSubview(pictureView)
        
        iconView.snp_makeConstraints { (make) in
            
            make.left.top.equalTo(XDLStatusCellMargin)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp_right).offset(XDLStatusCellMargin)
        }
        
        memberIconView.snp_makeConstraints { (make) in
            
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_right).offset(XDLStatusCellMargin)
        }
        
        createTime.snp_makeConstraints { (make) in
            
            //make.top.equalTo(nameLabel.snp_bottom).offset(8)
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(iconView)
            
        }
        
        sourceLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(createTime.snp_right).offset(XDLStatusCellMargin)
            make.top.equalTo(createTime)
        }
        
        avatarView.snp_makeConstraints { (make) in
            
            make.centerY.equalTo(iconView.snp_bottom).offset(-2)
            make.centerX.equalTo(iconView.snp_right).offset(-2)
            
        }
        
        contentLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(XDLStatusCellMargin)
           
        }
        
        pictureView.snp_makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp_bottom).offset(XDLStatusCellMargin)
            make.leading.equalTo(contentLabel)
        }
        
        self.snp_makeConstraints { (make) in
         
        self.bottomCons = make.bottom.equalTo(pictureView).offset(XDLStatusCellMargin).constraint
        }
        
    }
    
    
    //MARK: lazy var LayoutView
    
        private lazy var iconView :UIImageView = {()-> UIImageView in
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "avatar_default"))
        
        return iconView
    }()
    
        private lazy var nameLabel :UILabel = {()-> UILabel in
        
        let nameLabel = UILabel(textColor: UIColor.darkGray, fontSize: 14)
        
        nameLabel.text = "DarlingXie"
        
        return nameLabel
    }()
    
        private lazy var memberIconView:UIImageView = {()-> UIImageView in
        
        let memberIconView = UIImageView(image: #imageLiteral(resourceName: "common_icon_membership"))
    
        return memberIconView
    }()
    
        private lazy var createTime :UILabel = {()-> UILabel in
        
        let createTime = UILabel(textColor: UIColor.darkGray, fontSize: 12)
        
        createTime.text = "time"
        
        return createTime
    }()
    
        private lazy var sourceLabel :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.darkGray, fontSize: 12)
    
        label.text = "from where"
            
        return label
    
    }()

        private lazy var avatarView :UIImageView = {()-> UIImageView in
        
        let avatarView = UIImageView(image: #imageLiteral(resourceName: "avatar_vgirl"))
        
        //label.textColor = UIcolor.red
        
        return avatarView
    }()
    
       lazy var contentLabel :UILabel = {()-> UILabel in
        
        let contentLabel = UILabel(textColor: UIColor.darkGray, fontSize: 14)
        
        contentLabel.numberOfLines = 0
        
        contentLabel.text = "sdfasdfadsfadsfasdfadsfafdsfadsf"
        
        contentLabel.preferredMaxLayoutWidth = XDLScreenW - 2 * XDLStatusCellMargin
        
        return contentLabel
    }()

    private lazy var pictureView :XDLStatusPictureView = {()-> XDLStatusPictureView in
        
        let pictureView = XDLStatusPictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        //label.textColor = UIcolor.red
        pictureView.backgroundColor = self.backgroundColor
        return pictureView
    }()

}
