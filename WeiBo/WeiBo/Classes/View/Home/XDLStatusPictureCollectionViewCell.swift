//
//  XDLStatusPictureCollectionViewCell.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLStatusPictureCollectionViewCell: UICollectionViewCell {
    
    var pictureInfo:XDLStatusPictureInfo?{
        
        didSet{
            
            imageView.sd_setImage(with: URL(string:pictureInfo?.thumbnail_pic ?? ""), placeholderImage: UIImage(named:"timeline_image_placeholder"))
        }
        
    }
    override init(frame:CGRect){
            super.init(frame: frame)
            setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        contentView.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
    }
    
    private  lazy var imageView : UIImageView = {()-> UIImageView in
    
         let imageView = UIImageView()
        
         imageView.contentMode = UIViewContentMode.scaleAspectFill
        
         imageView.clipsToBounds = true
        
         return imageView
    }()

}
