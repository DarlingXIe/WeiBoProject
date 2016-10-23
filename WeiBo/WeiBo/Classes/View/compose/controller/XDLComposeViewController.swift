//
//  XDLComposeViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/30.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

import SVProgressHUD

class XDLComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(emotionButtonClick(noti:)), name: NSNotification.Name(rawValue: XDLEmoticonButtonDidSelectedNotification), object: nil)
        
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    
    //MAEK: - notification funcation 
    @objc private func send(){
        
        //MARK: - decide to update textfile or picture
        if pictureView.images.count == 0{
            
            updateText()
        
        }else{
            
            uploadPictureWithText()
            
        }
       
    }
    
    private func updateText(){
        
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        let accessToken = XDLUserAccountViewModel.shareModel.access_token
        
        let params = [
            
            "access_token" : accessToken,
            "status": textView.emotionText ?? ""
        ]
        
        XDLNetWorkTools.sharedTools.request(method: .Post, urlSting: urlString, parameters: params) { (response, error) in
            if response == nil && error != nil {
                print(error)
                SVProgressHUD.showError(withStatus: "send error")
                return
            }else{
                print(response)
                SVProgressHUD.showSuccess(withStatus: "send successed")
            }
        }
    }

    private func uploadPictureWithText(){
        
        let urlSting = "https://upload.api.weibo.com/2/statuses/upload.json"
        
        let accessToken = XDLUserAccountViewModel.shareModel.access_token
        
        let params = [
            
            "access_token" : accessToken,
            
            "status" : textView.emotionText ?? ""
        
        ]
    
        let dict = [
            
            "png" : UIImagePNGRepresentation(self.pictureView.images.first!)!
        ]
        
        XDLNetWorkTools.sharedTools.requestUploadPost(method: .Post, urlSting: urlSting, params: params, fileDict: dict) { (response, error) in
            
            if error != nil{
                
                print(error)
                
                SVProgressHUD.showError(withStatus: "upload error")
                
                return
                
            }
            
                print(response)
            
                SVProgressHUD.showError(withStatus: "uplaod success")
            
        }
    
        XDLNetWorkTools.sharedTools.post(urlSting, parameters: params, constructingBodyWith: { (formData) in
            
             let data = UIImagePNGRepresentation(self.pictureView.images.first!)!
            
             formData.appendPart(withFileData: data, name: "png", fileName: "bbbb", mimeType: "application/octet-stream")
            
            }, progress: nil, success: { (response, _) in
                
                print("request successed")
                SVProgressHUD.showSuccess(withStatus: "upload success")
            
            }) { (_, error) in
                
                print("request failed")
                
                SVProgressHUD.showSuccess(withStatus: "upload failed")
            }
    }
    
    
    @objc private func keyBoardWillChangeFrame(noti: NSNotification){
        
        let frame = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let duration = (noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        print("键盘的最终的位置\(frame)")
        
        composeToolBar.snp_updateConstraints { (make) in
            make.bottom.equalTo(self.view).offset(frame.origin.y - XDLScreenH)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
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
    
    //MARK: NotificationCenter funciton to observer click emotionButtons
    @objc private func emotionButtonClick(noti: NSNotification){
        
        if noti.userInfo != nil {
            
         let emotion = noti.userInfo!["emotion"]! as! XDLEmotion
    
         textView.insertEmotion(emotion: emotion)
        
        }else{
        
        textView.deleteBackward()
            
        }
    
//        if emotion.type == 1{
//            textView.insertText((emotion.code! as NSString).emoji())
//        }else{
            //1. capture the bundle
//            let bundle = XDLEmotionViewModel.sharedViewModel.emotionBundle
//            let image = UIImage(named: "\(emotion.path!)/\(emotion.png!)", in: bundle, compatibleWith: nil)
//            //2. init with TextAttachment for image
//            
//            let attachment = NSTextAttachment()
//            //2.1 get the size of picture
//            let imageWH = textView.font!.lineHeight
//            attachment.bounds = CGRect(x: 0, y: -4, width: imageWH, height: imageWH)
//            //2.2
//            attachment.image = image
//            //3. 
//            let attr = NSMutableAttributedString(attributedString: textView.attributedText)
//            //attr.append(NSAttributedString(attachment:attachment))
//            //3.1 get mouse loaciton
//            var selectedRange = textView.selectedRange
////
////            attr.insert(NSAttributedString(attachment: attachment), at: selectedRange.location)
//            attr.replaceCharacters(in: selectedRange, with: NSAttributedString(attachment: attachment))
////
//              attr.addAttribute(NSFontAttributeName, value: textView.font!, range: NSMakeRange(0, attr.length))
//            
//             textView.attributedText = attr
//            
//             selectedRange.location += 1
////            
//             selectedRange.length = 0
////            
//             textView.selectedRange = selectedRange
//        }
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
        button.addTarget(self, action: #selector(send), for: .touchUpInside)
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

    internal lazy var emotionKeyBorad :XDLEmotionKeyBoard = {()-> XDLEmotionKeyBoard in
        
         let emotionKeyBorad = XDLEmotionKeyBoard()
        
        emotionKeyBorad.frame.size = CGSize(width: XDLScreenW, height: 216)
        
        return emotionKeyBorad
        
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
        
        if textView.inputView == nil{
            textView.inputView = emotionKeyBorad
        }else{
            textView.inputView = nil
        }
        textView.reloadInputViews()
        
        if !textView.isFirstResponder{
            textView.becomeFirstResponder()
        }
        
        composeToolBar.isSystemKeyBorad = textView.inputView == nil
        
    }
    
    internal func selectAdd(){
        print("click selectAdd button")
    }
    
    //MARK: -achieveDelegateFunctionToSelectImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //saving the memory for load images from devices. to shrink the images
        let img = image.scaleTo(width: 500)
        pictureView.addImage(image: img)
        let data = UIImagePNGRepresentation(img)!
        (data as NSData).write(toFile: "/Users/DalinXie/Desktop/bbbb.png", atomically: true)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

