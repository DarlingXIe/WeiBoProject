//
//  XDLTempViewController.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

/*
 static var token: dispatch_once_t = 0
 func whatDoYouHear() {
 print("All of this has happened before, and all of it will happen again.")
 dispatch_once(&token) {
 print("Except this part.")
 }
 }
 */

import UIKit



class XDLQRToolBarController: UIViewController {

    var flag = 0
    var qrCodeScanCons : Constraint?

    var QRScanViewCons: Constraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

          setupUI()
    }
   
    //MARK: - setupUI()
    private func setupUI(){
    
        title = "Scan QR Code"
        
        self.view.backgroundColor = UIColor.white
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(imgName: "compose_toolbar_picture", title: "", target: self, action: #selector(pushTestVc))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "navigationbar_back", title: " ", target: self, action: #selector(backToPrevious))
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        view.addSubview(SQToolBar)
        
        view.addSubview(QRScanView)
        
        SQToolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(49)
        }
        
        QRScanView.snp_makeConstraints { (make) in
           make.center.equalTo(self.view)
           self.QRScanViewCons = make.height.equalTo(300).constraint
           //make.height.constraint = self.QRScanViewCons?
           make.width.equalTo(300)
            
        }
        
        QRScanView.addSubview(qrCodeView)
        
        qrCodeView.addSubview(qrLineCodeView)
        
        qrCodeView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.QRScanView)
        }
        
        qrLineCodeView.snp_makeConstraints{(make) in
            make.width.equalTo(300)
           self.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
           make.top.equalTo(qrCodeView)
           make.left.equalTo(qrCodeView)
            //make.edges.equalTo(self.qrCodeView)
        }
        
        self.SQToolBar.clickSQClosure = {[weak self](type:XDLQRToolBarButtonType) -> () in
            print("****clickComposeButtons\(self)")
            switch type {
            case .SQCode:
                print("SQCode")
                self?.qrLineCodeView.layer.removeAllAnimations()
                self?.QRScanView.snp_updateConstraints{(make) in
                    make.height.equalTo(SQScanCodeWH)
                    self?.view.layoutIfNeeded()
                }
               self?.startAnimation(type: type)
               self?.flag = 0
            case .SQLongCode:
                if(self?.flag == 0){
                print("SQLongCode")
                self?.qrLineCodeView.layer.removeAllAnimations()
                //self?.QRScanViewCons?.uninstall()
                self?.QRScanView.snp_updateConstraints{(make) in
                self?.QRScanViewCons? = make.height.equalTo(SQScanCodeWH/2).constraint
                }
                self?.startAnimation(type: .SQLongCode)
                self?.flag = 1
                }
/****************************************************************/
//                   self?.qrCodeScanCons?.uninstall()
//                   self?.qrLineCodeView.snp_updateConstraints{(make) in
//                        //make.centerY.equalTo(-300)
//                        self?.qrCodeScanCons = make.height.equalTo(-SQScanCodeWH).constraint
//                    }
//                    self?.view.layoutIfNeeded()
//                    self?.qrCodeScanCons?.uninstall()
//                    UIView.animate(withDuration: 1.0) {
//                        UIView.setAnimationRepeatCount(MAXFLOAT)
//                        self?.qrLineCodeView.snp_updateConstraints{(make) in
//                            //make.centerY.equalTo(-300)
//                            SQScanCodeWH = SQScanCodeWH/2
//                            self?.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
//                        }
//                        self?.view.layoutIfNeeded()
//                    }
/****************************************************************/
            }
        }
    }
    private func startAnimation(type: XDLQRToolBarButtonType){
    
        qrCodeScanCons?.uninstall()
        //QRScanViewCons?.uninstall()
        qrLineCodeView.snp_updateConstraints{(make) in
            //make.centerY.equalTo(-300)
            self.qrCodeScanCons = make.height.equalTo(-SQScanCodeWH).constraint
        }
        self.view.layoutIfNeeded()
       
//        UIView.animate(withDuration: 1.0) {
//            UIView.setAnimationRepeatCount(MAXFLOAT)
//            self.qrLineCodeView.snp_updateConstraints{(make) in
//                //make.centerY.equalTo(-300)
////                SQScanCodeWH = (type == .SQLongCode) ?    (SQScanCodeWH + 10) : SQScanCodeWH/2
//               if(type == .SQLongCode){
//                SQScanCodeWH = SQScanCodeWH/2
//                self.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
//               }else{
//                self.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
//                }
//            }
//            self.view.layoutIfNeeded()
//        }
         UIView.animate(withDuration: 1.0, animations: {
            
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.qrLineCodeView.snp_updateConstraints{(make) in
                //make.centerY.equalTo(-300)
                //                SQScanCodeWH = (type == .SQLongCode) ?    (SQScanCodeWH + 10) : SQScanCodeWH/2
                if(type == .SQLongCode){
                    SQScanCodeWH = SQScanCodeWH/2
                    self.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
                }else{
                    self.qrCodeScanCons = make.height.equalTo(SQScanCodeWH).constraint
                }
            }
            self.view.layoutIfNeeded()
            
            }) { (_) in
//                self.QRScanView.snp_updateConstraints{(make) in
//                    self.QRScanViewCons? = make.height.equalTo(SQScanCodeWH).constraint
//                }
                
                 SQScanCodeWH = 300
                 self.view.layoutIfNeeded()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("qrLineCodeView appear")
        
        qrCodeScanCons?.uninstall()
        qrLineCodeView.snp_updateConstraints{(make) in
            self.qrCodeScanCons = make.height.equalTo(-SQScanCodeWH).constraint
        }
        self.view.layoutIfNeeded()
        qrCodeScanCons?.uninstall()
        UIView.animate(withDuration: 1.0) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.qrLineCodeView.snp_updateConstraints{(make) in
                self.qrCodeScanCons = make.height.equalTo( (SQScanCodeWH + 10)).constraint
            }
            self.view.layoutIfNeeded()
        }
        
    }

    //click navigationItemButton
        @objc private func pushTestVc(){
        print("Album")
        
    }
    //click navigationBackItemButton
        @objc private func backToPrevious(){
     _ = navigationController?.popViewController(animated: true)
        
     // navigationController?.navigationBar.barTintColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/250.0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - lazy var UI
   internal lazy var SQToolBar :XDLQRToolBar = {()-> XDLQRToolBar in
        
        let SQToolBar = XDLQRToolBar()
        
        //label.textColor = UIcolor.red
        
        return SQToolBar
    }()

    internal lazy var QRScanView :XDLQRScanView = {()-> XDLQRScanView in
        
        let QRScanView = XDLQRScanView()
        
        return QRScanView
    }()
    
    internal lazy var qrCodeView :UIImageView = {()-> UIImageView in
        
        let QRScanView = UIImageView(image:UIImage(named:"qrcode_border"))
        return QRScanView
    }()
    
    internal lazy var qrLineCodeView :UIImageView = {()-> UIImageView in
        
        let QRLineScanView = UIImageView(image: UIImage(named: "qrcode_scanline_qrcode"))
        
        return QRLineScanView
    }()

}
