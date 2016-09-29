//
//  XDLComposeView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/28.
//  Copyright © 2016年 itcast. All rights reserved.
//
/*
    hints: 
            1. create UIButtonClass to setupUI with imageView and label. recall the funcation with layout subviews to layout subviews setting its frame
 
            2. composeView add the screenSnap and titleLabel and import the snapScreen.h to make image from snap
 
 */
import UIKit

class XDLComposeView: UIView {

    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    private func setupUI(){
        
        //backgroundColor = UIColor.black
        frame.size = UIScreen.main.bounds.size
        
        addSubview(bgImage)
        addSubview(logoLabel)
        
        bgImage.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        logoLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(200)
        }
        
        addChildButton()
    
    }
    
    //MARK: - func addChildButtons()
    func addChildButton(){
        
        // the width of button itemW: 
        // the height of button itemH:
        let itemW:CGFloat = 80
        let itemH:CGFloat = 110
        //cal the margin for eachbuttons
        let itemMargin = (XDLScreenW - 3 * itemW)/4
        //information from list for buttonPicture and title
        let path = Bundle.main.path(forResource: "compose.plist", ofType: nil)!
        //array from plist
        let array = NSArray(contentsOfFile: path)!
        
        for i in 0..<array.count{
            //create Button 
            let button = XDLComposeButton(textColor: UIColor.lightGray, fontSize: 14)
            //info about picture and tilte
            let dict = array[i] as![String : String]
            //buttoninfor with image and title from the dict
            button.setImage(UIImage(named:dict["icon"]!), for: .normal)
            button.setTitle(dict["title"], for: .normal)
            //col two tows and three cols
            let col = i % 3
            let row = i / 3
            
            let x = CGFloat(col) * itemW + CGFloat(col + 1) * itemMargin
            
            let y = CGFloat(row) * itemH + XDLScreenH
            
            button.frame.origin = CGPoint(x: x, y: y)
            
            addSubview(button)
        }
    
    }
    
    //MARK: - click screen to remove view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    //MARK: - lazy var to create the UI
    
    private lazy var bgImage :UIImageView = {()-> UIImageView in
        
        let imageView = UIImageView(image: UIImage.getScreenSnap()?.applyLightEffect())
        
        return imageView
        
    }()

   private lazy var logoLabel :UIImageView = {()-> UIImageView in
        
        let imageView = UIImageView(image: UIImage(named: "compose_slogan"))
    
        return imageView
    }()
    
    //MARK: - make screenSnap
    private func getScreenSnap() -> UIImage?{
    
        //capture the window
        let window = UIApplication.shared.keyWindow
        //beginImageContext with window size
        UIGraphicsBeginImageContextWithOptions(window!.bounds.size, false, 0)
        //draw context with window with beginImageContextSize
        window?.drawHierarchy(in: window!.bounds, afterScreenUpdates: false)
        //capture the image from the windowContext
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //end context
        UIGraphicsEndImageContext()
        //reture image
        return image
    }
    

}
