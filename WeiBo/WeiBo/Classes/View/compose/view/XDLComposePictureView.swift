//
//  XDLComposePictureView.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit
import SVProgressHUD
//MARK: - 1.register cells' Id
private let XDLComposePictureViewCellId = "ComposePictureViewCellId"

class XDLComposePictureView: UICollectionView {

    
    var addImageClosure: (() -> ())?
    
    internal lazy var images :[UIImage] = [UIImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout){
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        self.register(XDLComposePictureViewCell.self, forCellWithReuseIdentifier: XDLComposePictureViewCellId)
        self.dataSource = self
        self.delegate = self
    }
    
    func addImage(image: UIImage){
        
        if images.count < 9 {
            images.append(image)
            reloadData()
        }else{
            SVProgressHUD.showError(withStatus: "beyond")
        }
    }

//MARK: - 2. setup size of item for collectionView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemMargin: CGFloat = 5
        
        let itemWH = (self.frame.width - 2 * itemMargin) / 3
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        layout.minimumLineSpacing = itemMargin
        
        layout.minimumInteritemSpacing = itemMargin
        
    }
    
}
//MARK: - 3.Load Image Data to cell.image

//extension XDLComposePictureView: UICollectionViewDelegate{
//    
//    //MARK: - recall the funcation about didSelectItem to know that if the cell is last one, it should be addButton
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("click:")
//        if indexPath.item == images.count{
//            addImageClosure?()
//        }
//    }
//
//    override func numberOfItems(inSection section: Int) -> Int {
//   
//        return (images.count == 0 || images.count == 9) ? images.count : images.count + 1
//    }
//    
//
//   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XDLComposePictureViewCellId, for: indexPath) as! XDLComposePictureViewCell
//        
//        if indexPath.item < images.count{
//            
//            cell.image = images[indexPath.item]
//        
//        }else{
//            
//            cell.image = nil
//        }
//        
//        cell.deleteClickClosure = {[weak self] in
//            
//            self?.images.remove(at: indexPath.item)
//            self?.reloadData()
//        }
//        
//        return cell
//    }
//
//}
extension XDLComposePictureView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击")
        collectionView.deselectItem(at: indexPath, animated: true)
        // 要在这个地方判断是否是最后一个cell点击
        if indexPath.item == images.count {
            // 代表是最后一个cell代表是加号按钮
            // 要在这个地方通知外界去弹出控制器
            addImageClosure?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 如果count为0或者为9的话，都不显示+按钮，否则要显示，要显示的话就多返回一个cell
        return (images.count == 0 || images.count == 9) ? images.count : images.count + 1
        // return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XDLComposePictureViewCellId, for: indexPath) as! XDLComposePictureViewCell
        
        
        if indexPath.item < images.count {
            // 给cell设置数据
            let image = images[indexPath.item]
            cell.image = image
        }else{
            cell.image = nil
        }
        
        cell.deleteClickClosure = {[weak self] in
            // 在这个闭包里面删除数组里面对应位置的图片
            self?.images.remove(at: indexPath.item)
            // 刷新数据
            self?.reloadData()
        }
        return cell
    }
}

//MARK: - 4.setupUI for cells and register for cells

class XDLComposePictureViewCell:UICollectionViewCell{
    
    var deleteClickClosure:(() ->())?
    
    var image: UIImage?{
        
        didSet{
            if image == nil{
                imageView.image = UIImage(named: "compose_pic_add")
                imageView.highlightedImage = UIImage(named: "compose_pic_add_highlighted")
            }else{
                imageView.image = image
                imageView.highlightedImage = image
            }
                deleteButton.isHidden = image == nil
        }
    
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
        contentView.addSubview(imageView)
        
        contentView.addSubview(deleteButton)
        
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        deleteButton.snp_makeConstraints { (make) in
            make.top.right.equalTo(contentView)
        }
    }
    
    @objc private func clickDelectButton(){
        
        print("deleteClickButtion")
        
        deleteClickClosure?()
        
    }
   
    private lazy var imageView :UIImageView = {()-> UIImageView in
        
        let imageView = UIImageView()
        
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        imageView.clipsToBounds = true
        
        //label.textColor = UIcolor.red
        return imageView
    }()

    private lazy var deleteButton :UIButton = {()-> UIButton in
        
         let button = UIButton()
         button.addTarget(self, action: #selector(clickDelectButton), for: .touchUpInside)
         button.setImage(UIImage(named:"compose_photo_close"), for: .normal)
         return button
    }()

}





