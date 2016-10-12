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
    
    lazy var emtionButtons = [XDLEmotionButton]()
    
    var emotions : [XDLEmotion]?{
        
        didSet{
            print(emotions)
        //MARK: add buttons for each cell
            for button in emtionButtons{
                button.isHidden = true
            }
            
            for (index, emotion) in emotions!.enumerated(){
            
                let button = emtionButtons[index]
                
                button.isHidden = false
                
                button.emotions = emotion
            
            }
        }
    }
    
    var indexpPath: IndexPath?{
        
        didSet{
            
            Testlabel.text = "第\(indexpPath!.section)组, 第 \(indexpPath!.item)页"
            recentEmotionLabel.isHidden = indexpPath!.section != 0
        }
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupUI()
        addButtons()
        contentView.addSubview(deleteButton)
        contentView.addSubview(recentEmotionLabel)
        recentEmotionLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp_centerX)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        
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
            deleteButton.frame = CGRect(x: self.bounds.width - itemW, y: itemH * 2, width: itemW, height: itemH)
    
    }
    
    //itemW = self.screen.width/3
    //itemH = self.screen.height/21
    // col = index % 3
    // row = index /3
    // let x = CGFloat(col) * itemW
    // let y = CGFLoat(row) * itemH
    private func setupUI(){
    
        contentView.addSubview(Testlabel)
        
        Testlabel.snp_makeConstraints { (make) in
        make.center.equalTo(self)
            
          
        
        }
        let ges = UILongPressGestureRecognizer(target: self, action: #selector(longPress(ges:)))
        addGestureRecognizer(ges)
    
    }
    
    
    @objc private func longPress(ges: UILongPressGestureRecognizer){
        
        
        
        
    }
    
    
    
    //MARK: - addChildButtons
    private func addButtons(){
        
        for _ in 0..<XDLEmotionButtonsCount{
            
            let button =  XDLEmotionButton()
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 34)
            //button.backgroundColor = RandomColor
            
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

    private lazy var deleteButton :UIButton = {()-> UIButton in
        
        let button = UIButton()
        button.setImage(UIImage(named: "compose_emotion_delete_highlighted"), for: .highlighted)
        button.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
        return button
    }()

    private lazy var recentEmotionLabel :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.lightGray, fontSize: 12)
        
        label.text = "Recent emotions"
        
        return label
    }()

    
}
