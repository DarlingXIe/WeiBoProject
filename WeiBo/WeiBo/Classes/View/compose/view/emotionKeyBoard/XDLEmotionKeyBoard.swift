//
//  XDLEmotionKeyBoard.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

private let emotionCollectionViewCellId = "emotionCollectionViewCellId"

class XDLEmotionKeyBoard: UIView {

    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        setupUI()
        let result = XDLEmotionViewModel.sharedViewModel.allEmotions
        print(result)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor(patternImage: UIImage(named:"emoticon_keyboard_background")!)
        
        addSubview(emotionToolBar)
        
        addSubview(emotionCollectionView)
        
        emotionToolBar.snp_updateConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(37)
        }
        
        emotionCollectionView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(emotionToolBar.snp_bottom)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = emotionCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 0
        
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        
        layout.itemSize = emotionCollectionView.frame.size
    }
    
    internal lazy var emotionToolBar :XDLEmotionToolBar = {()-> XDLEmotionToolBar in
        
        let toolBar = XDLEmotionToolBar()
        
        toolBar.emotionTypeChangedClosure = {(type) -> () in
            
            print("switchButtons\(type)")
            
        }
        
        return toolBar
    }()
    
    internal  lazy var emotionCollectionView :UICollectionView = {()-> UICollectionView in
        
        let layout = UICollectionViewFlowLayout()
        
        let emotionCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        emotionCollectionView.dataSource = self
        
        emotionCollectionView.delegate = self
        
        emotionCollectionView.register(XDLEmotionCollectionViewCell.self, forCellWithReuseIdentifier: emotionCollectionViewCellId)
        
        emotionCollectionView.showsHorizontalScrollIndicator = false
        
        emotionCollectionView.showsVerticalScrollIndicator = false
        
        emotionCollectionView.isPagingEnabled = true
        
        emotionCollectionView.bounces = true
        //label.textColor = UIcolor.red
        
        return emotionCollectionView
    }()

}


extension XDLEmotionKeyBoard: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return XDLEmotionViewModel.sharedViewModel.allEmotions.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return XDLEmotionViewModel.sharedViewModel.allEmotions[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emotionCollectionViewCellId, for: indexPath) as! XDLEmotionCollectionViewCell
        cell.indexpPath = indexPath
        cell.emotions = XDLEmotionViewModel.sharedViewModel.allEmotions[indexPath.section][indexPath.item]
        cell.backgroundColor = RandomColor
        
        return cell
    }

}



