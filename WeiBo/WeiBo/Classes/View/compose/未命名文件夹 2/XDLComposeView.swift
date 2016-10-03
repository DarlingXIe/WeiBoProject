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
import pop

class XDLComposeView: UIView {

    //define the controller from outside
    var target : UIViewController?
    
    // define the array with button
    lazy var buttons :[UIButton] = {()-> [UIButton] in
        
        let button = [UIButton]()
        //label.textColor = UIcolor.red
        return button
    }()

    var infoArray: NSArray?
    
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
        self.infoArray = array
        for i in 0..<array.count{
            //create Button 
            let button = XDLComposeButton(textColor: UIColor.darkGray, fontSize: 14)
            
            button.addTarget(self, action: #selector(childButtonClick(button:)), for: .touchUpInside)
            //info about picture and tilte
            let dict = array[i]as![String : String]
            //buttoninfor with image and title from the dict
           button.setImage(UIImage(named:dict["icon"]!), for: .normal)
            
           //button.setImage(UIImage(named: "tabbar_compose_weibo"), for: UIControlState.normal)
            
            button.setTitle(dict["title"], for: .normal)
            //add width and height for buttons
            button.frame.size = CGSize(width: itemW, height: itemH)
            //col two tows and three cols
            let col = i % 3
            let row = i / 3
            
            let x = CGFloat(col) * itemW + CGFloat(col + 1) * itemMargin
            
            let y = CGFloat(row) * itemH + XDLScreenH
            
            button.frame.origin = CGPoint(x: x, y: y)
            
            addSubview(button)
            
            buttons.append(button)
            
        }
    
    }
    
    //MARK: - to show this XDLComposeView
    
    func show(target: UIViewController){
        
        self.target = target
        //let window = UIApplication.shared.keyWindow
        //window?.addSubview(self)
        self.target?.view.addSubview(self)
        
        for(index,value) in buttons.enumerated(){
            
            buttonAnimation(index: index, button: value, isPullUp: true)
            
        }
    }
    
    //MARK: - setting the buttons animation
    func buttonAnimation(index: Int, button: UIButton, isPullUp:Bool){
        
        let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        anim?.toValue = NSValue.init(cgPoint: CGPoint(x: button.center.x, y: button.center.y + (isPullUp ? -300 : 300)))
        
        anim?.springBounciness = 12
        
        anim?.springSpeed = 10
        
        if isPullUp{
            anim?.beginTime = CACurrentMediaTime() + Double(index)*0.25
        }else{
            anim?.beginTime = CACurrentMediaTime()
        }
        button.pop_add(anim, forKey: nil)
    }
    
    //MARK: - click screen to remove view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for (index, button) in buttons.reversed().enumerated(){
            
            buttonAnimation(index: index, button: button, isPullUp: false)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.removeFromSuperview()
        }
        
    }

    
    //MARK: - clickButton
    
   @objc private func childButtonClick(button:UIButton){
    
    UIView.animate(withDuration: 1, animations: { 
        for value in self.buttons{
            
            if button == value{
                value.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            }else{
                value.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
            }
            value.alpha = 0.1
        }

        }) { (_) in
            print("-----controller")
            let index = self.buttons.index(of: button) ?? 0
            
            let dict = self.infoArray![index] as![String : String]
            
            if let name = dict["class"]{
                
                //let result = NSStringFromClass(XDLComposeViewController.self)
                
                let type = NSClassFromString(name)! as! UIViewController.Type
                
                let vc = type.init()
                
                self.target?.present(XDLNavigationViewController(rootViewController: vc), animated: true, completion: {
                    self.removeFromSuperview()
                })
            }
        }
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
