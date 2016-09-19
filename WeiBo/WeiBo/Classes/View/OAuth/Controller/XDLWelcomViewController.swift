//
//  XDLWelcomViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

import SDWebImage

class XDLWelcomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
        
        let url = URL(string: (XDLUserAccountViewModel.shareModel.countModel?.profile_image_url)!)
        
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default"))
        
    }
    
    private func setupUI(){
        
       self.view.backgroundColor = UIColor(white: 237/255, alpha: 1)
       
        view.addSubview(imageView)
        
        view.addSubview(buttomLabel)
        
        imageView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 90, height: 90))
            make.top.equalTo(200)
            make.centerX.equalTo(self.view)
        }
        
      buttomLabel.snp_makeConstraints { (make) in
           make.centerX.equalTo(imageView)
           make.top.equalTo(imageView.snp_bottom).offset(15)
        }
       
    }
    
    //MARK: - lazy imageView and Label
    
    lazy var imageView :UIImageView = {()-> UIImageView in
        
        let imageView = UIImageView(image:UIImage(named:"avatar_default"))
       
        imageView.layer.cornerRadius = 45
        
        imageView.layer.masksToBounds = true
        //label.textColor = UIcolor.red
        imageView.layer.borderColor = UIColor.gray.cgColor
        
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    lazy var buttomLabel:UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.darkGray, fontSize: 16)
        
        label.alpha = 0
        
        label.text = "welcome back"
        
      //  label.sizeToFit()
        
        return label

    }()
    
    //MARK: - animation for welcomeView
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.imageView.snp_updateConstraints { (make) in
            make.top.equalTo(100)
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { 
            self.view.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1, animations: { 
                    self.buttomLabel.alpha = 1
                    }, completion: { (_) in
                        
                      NotificationCenter.default.post(name: NSNotification.Name(XDLChangeRootController), object: nil)
                })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
