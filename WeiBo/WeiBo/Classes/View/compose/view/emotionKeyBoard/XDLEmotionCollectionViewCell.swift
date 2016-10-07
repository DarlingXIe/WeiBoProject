//
//  XDLEmotionCollectionViewCell.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLEmotionCollectionViewCell: UICollectionViewCell {
    
    var emotions : [XDLEmotion]?{
        
        didSet{
            print(emotions)
        //MARK: add buttons for each cell
            
        }
    
    }
    
    var indexpPath: IndexPath?{
        
        didSet{
            
            Testlabel.text = "第\(indexpPath!.section)组, 第 \(indexpPath!.item)页"
            
        }
    
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    
        contentView.addSubview(Testlabel)
        
        Testlabel.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var Testlabel : UILabel = {()-> UILabel in
        
        let label = UILabel()
        
        return label
    }()

    
}
