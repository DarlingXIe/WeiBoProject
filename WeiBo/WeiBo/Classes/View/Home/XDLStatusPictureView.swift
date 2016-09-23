//
//  XDLStatusPictureView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLStatusPictureView: UICollectionView {
    
    override init(frame:CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        
        backgroundColor = UIColor.orange
    
    }
    
}
