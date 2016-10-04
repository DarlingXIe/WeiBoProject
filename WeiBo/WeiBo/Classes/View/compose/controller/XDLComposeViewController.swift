//
//  XDLComposeViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    private func setupUI() {
//        
//        self.view.backgroundColor = UIColor.black
//    
//    }
    //MARK: back function
    @objc internal func back(){
    
        self.dismiss(animated: true, completion: nil)
        
    }
    //MARK: - setting UI lazy var
    internal lazy var titleLable :UILabel = {()-> UILabel in
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        if let name = XDLUserAccountViewModel.shareModel.countModel?.name{
        let title = "Update Status\n\(name)"
        let attributedText = NSMutableAttributedString(string: title)
        let range = (title as NSString).range(of: name)
            
        attributedText.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray], range: range)
            
        titleLabel.attributedText = attributedText
            
        }else{
            
            titleLabel.text = "Update Status"
            titleLabel.textColor = UIColor.black
        }
    
        titleLabel.sizeToFit()
        return titleLabel
   }()
    
    internal lazy var rightButton :UIButton = {()-> UIButton in
        
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_orange"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_orange_highlighted"), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_white_disable"), for: .disabled)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Post", for: .normal)
        button.frame.size = CGSize(width: 44, height: 30)
        return button
        
    }()

    //MARK: myLazyVar textView
    internal lazy var textView :XDLTextView = {()-> XDLTextView in
        
         let textView = XDLTextView()
        
         textView.delegate = self
        
         textView.placeholder = "What's on your mind?"
        
         textView.font = UIFont.systemFont(ofSize: 16)
        
         textView.alwaysBounceVertical = true
        
         return textView
        
    }()
    
    internal lazy var composeToolBar :XDLComposeToolBar = {()-> XDLComposeToolBar in
        
        let composeToolBar = XDLComposeToolBar()
    
        return composeToolBar
    }()
    
    internal lazy var pictureView :XDLComposePictureView = {()-> XDLComposePictureView in
        
        let view = XDLComposePictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        view.backgroundColor = UIColor.white
        
        //label.textColor = UIcolor.red
        view.addImageClosure = {[weak self] in
            print("click add button")
            self?.selectPicture()
        }
        
        return view
    }()

    var image: UIImage?

}

//MARK: - delegateTextView

extension XDLComposeViewController:UITextViewDelegate{

    func textViewDidChange(_ textView: UITextView) {
        
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    
    }

}

//MARK: - 在同类中设置extension

extension XDLComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func setupUI(){
        
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back to home", target: self, action: #selector(back))
        navigationItem.titleView = titleLable
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(self.textView)
        
        view.addSubview(self.composeToolBar)
        
        textView.addSubview(pictureView)
        
        
        
        //MARK: - judge buttonsType
        self.composeToolBar.clickButtonClosure = {[weak self] (type) ->() in
        
            print("****clickComposeButtons\(self)")
            
            switch type {
            case .picture:
                self?.selectPicture()
            case .mention:
                self?.selectMention()
            case .trend:
                self?.selectTrend()
            case .emotion:
                self?.selectEmotion()
            case .add:
                self?.selectAdd()
            }
            
        }
        
        textView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        composeToolBar.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        pictureView.snp_makeConstraints { (make) in
            make.top.equalTo(textView).offset(100)
            make.left.equalTo(textView).offset(10)
            make.width.equalTo(textView.snp_width).offset(-20)
            make.height.equalTo(textView.snp_height)
        }
    }
    //MARK: - selectButtonsFunc
    internal func selectPicture(){
       
        let vc = UIImagePickerController()
        
        vc.delegate = self
        // 判断前置或者后置摄像头是否可用
        // UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice)
        
        // 判断某个数据类型是否可用
        // if UIImagePickerController.isSourceTypeAvailable(.camera) == false{
        //          print("照相机不可用")
        // }
        vc.sourceType = .photoLibrary
        
        vc.allowsEditing = true
        
        self.present(vc, animated: true) { 
            print("present UIImagePicker")
        }
        
    }
    internal func selectMention(){
        print("click selectMention button")
    }
    internal func selectTrend(){
        print("click selectTrend button")
    }
    internal func selectEmotion(){
        print("click selectEmotion button")
    }
    internal func selectAdd(){
        print("click selectAdd button")
    }
    
    //MARK: -achieveDelegateFunctionToSelectImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let img = image.scaleTo(width: 500)
        pictureView.addImage(image: img)
        let data = UIImagePNGRepresentation(img)!
        (data as NSData).write(toFile: "/Users/DalinXie/Desktop/bbbb.png", atomically: true)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

