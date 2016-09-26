//
//  XDLStatusPictureView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

import SDWebImage

private let itemMargin : CGFloat = 5

private let itemWH = (XDLScreenW - 2 * XDLStatusCellMargin - 2 * itemMargin) / 3

class XDLStatusPictureView: UICollectionView{
    
    
    let XDLPictureViewCellId = "cell"
    
    var pic_urls:[XDLStatusPictureInfo]?{
        
        didSet{
            
            self.snp_updateConstraints { (make) in
                make.size.equalTo(calcSize(count: (pic_urls?.count) ?? 0))
            }
            
            self.reloadData()
        }
    }
    
    override init(frame:CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        
        backgroundColor = UIColor.white
    
        self.register(XDLStatusPictureCollectionViewCell.self, forCellWithReuseIdentifier: XDLPictureViewCellId)
        //setting collectionView layout
        self.dataSource = self
        //as! to UICollectionViewLayout
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        layout.minimumLineSpacing = itemMargin
        
        layout.minimumInteritemSpacing = itemMargin
        
    }
    
    private func calcSize(count: Int) -> CGSize{
    
        
        if count == 1{
            
            if let size = pic_urls?.first?.size{
                
                let scale = UIScreen.main.scale
                
                var result = CGSize(width: scale * size.width, height: scale * size.height)
                
                if result.width < 50{
                    
                    result.width = 50
                    
                    result.height = 50 /  result.width * result.height
                    
                    if result.height > 300{
                        // 60 400
                        //    300
                        result.height = 300
                        
                        result.width = 300 * result.width/result.height
                    
                    }
                }
                
                
                let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
                
                layout.itemSize = result
                
                return result
            
            }
            
        }
        
        var col = count > 3 ? 3 : count
        
        if count == 4 {
            col = 2
        }
        
        let row = (count - 1)/3 + 1
    
        let width = CGFloat(col) * itemWH + CGFloat(col - 1) * itemMargin
        
        let height = CGFloat(row) * itemWH  + CGFloat(row - 1) * itemMargin
        
        let size = CGSize(width: width, height: height)
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        return size
    }
    
}

extension XDLStatusPictureView:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pic_urls?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:XDLPictureViewCellId, for: indexPath) as! XDLStatusPictureCollectionViewCell
        
        cell.pictureInfo = pic_urls![indexPath.item]
        
        return cell
    }


}

