//
//  XDLEmotionCollectionViewCell.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

let XDLEmotionButtonsCount = 20;

class XDLEmotionCollectionViewCell: UICollectionViewCell {
    
    lazy var emtionButtons = [UIButton]()
    
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
        setupUI()
        addButtons()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemW = self.bounds.size.width/7
        let itemH = self.bounds.size.height/3
    
        for(index, value) in emtionButtons.enumerated(){
            
            // buttons for 6, col = 6%7 = 6, row = 6/7 = 6; for 7 col = 7%7 = 0  row = 7/7 = 1
            let col = index % 7
            
            let row = index / 7
            
            let x = CGFloat(col) * itemW
            
            let y = CGFloat(row) * itemH
            
            value.frame = CGRect(x: x, y: y, width: itemW, height: itemH)
            
        }
    
    }
    
    private func setupUI(){
    
        contentView.addSubview(Testlabel)
        
        Testlabel.snp_makeConstraints { (make) in
        make.center.equalTo(self)
        }
    
}
    private func addButtons(){
        
        for _ in 0..<XDLEmotionButtonsCount{
            
            let button =  UIButton()
            
            button.backgroundColor = RandomColor
            
            contentView.addSubview(button)
            
            emtionButtons.append(button)
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
