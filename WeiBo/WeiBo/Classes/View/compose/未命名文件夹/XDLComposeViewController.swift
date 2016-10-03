//
//  XDLComposeViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/30.
//  Copyright © 2016年 itcast. All rights reserved.
//
//  201608021414510415.png

import UIKit

class XDLComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        //MARK -register notification to monitor keyBoradChanges
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - NotificationFunc to monitor the final position for frame.origin.y
    
    @objc private func keyboradWillChangeFrame(noti:Notification){
        
        let frame = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let duration = (noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
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

extension XDLComposeViewController {
    
    internal func setupUI(){
        
        self.view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back to home", target: self, action: #selector(back))
        
        navigationItem.titleView = titleLable
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(self.textView)
        
        view.addSubview(self.composeToolBar)
        //MARK: - closure recall
        self.composeToolBar.clickbuttonclosure = {[weak self] (toolBar: XDLComposeToolBar, type: composeToolBarButtonType) ->() in
            print("****clickToolBarButton****\(self)")
            switch type {
            case .picture:
                self?.selectPicture()
                break
            case .mention:
                print("@")
                self?.selectMention()
            case .trend:
                print("#")
                self?.selectTrend()
            case .emotion:
                print("emotion")
                self?.selectEmotion()
            case .add:
               print("+")
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

    }

    //MARK: - selectToolBarButtons
    internal func selectPicture(){
            print("click picture button")
        let vc = UIImagePickerController()
        
        vc.delegate = self
        
        //there are two func to judage 
        //1. rear camera or fount is used or not
       //UIImagePickerController.isSourceTypeAvailable(<#T##sourceType: UIImagePickerControllerSourceType##UIImagePickerControllerSourceType#>)
        //2. some properities in UIImagePickerController are avariable or not
       //     UIImagePickerController.isSourceTypeAvailable(<#T##sourceType: UIImagePickerControllerSourceType##UIImagePickerControllerSourceType#>)
        
        vc.sourceType = .photoLibrary
        
        vc.allowsEditing = true
            
        self.present(vc, animated: true) {
            print("Finish vc")
        }
    }
    
    internal func selectMention(){
            print("click mention button")
    }
    
    internal func selectTrend(){
            print("click trend button")
    }
    
    internal func selectEmotion(){
            print("click emotion button")
    }
    
    internal func selectAdd(){
            print("click add button")
    
    }

}
//MARK: - clickButtonsToAchieveDelegateFunctionFor pick picture from the albums

extension XDLComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // using imagePickerController, should dismiss by yourself
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //select the images from the array, image should be shrinked
        //let img = image
        
        let data = UIImagePNGRepresentation(image)!
        (data as NSData).write(toFile:"")
        picker.dismiss(animated: true, completion: nil)
    }

}

