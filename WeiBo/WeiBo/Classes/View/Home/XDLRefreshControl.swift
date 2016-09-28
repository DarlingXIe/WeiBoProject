//
//  XDLRefreshControl.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

enum XDLRefreshType: String {
    case normal = "normal" // defrault:
    case pulling = "pulling" // pulling:
    case refreshing = "refreshing" // pulling away:
}

private let XDLRefreshControlH: CGFloat = 50

private let XDLRefreshControlW: CGFloat = 50

class XDLRefreshControl: UIControl{
    
    //MARK: - recording different values for refreshType
    var refreshState : XDLRefreshType = .normal {
        
        didSet{

            switch refreshState {
            case .pulling:
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.arrowImage.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
                })
                
                self.label.text = "preparing loading..........."
                
            case .normal:
                
                indicatorView.stopAnimating()
                arrowImage.isHidden = false
                UIView.animate(withDuration: 0.25, animations: { 
                    self.arrowImage.transform = CGAffineTransform.identity
                })
                self.label.text = "preparing loading.........."
                
               // if state is refreshState, so change the contraints for tableView
                if oldValue == .refreshing {
                    
                UIView.animate(withDuration: 0.25, animations: {
                    var inset = self.scrollView!.contentInset
                    inset.top -= XDLRefreshControlH
                    self.scrollView!.contentInset = inset
                })
            }

            case .refreshing:
                arrowImage.isHidden = true
                indicatorView.startAnimating()
                self.label.text = "loading..........."
                UIView.animate(withDuration: 0.25, animations: { 
                    var inset = self.scrollView!.contentInset
                    inset.top += XDLRefreshControlH
                    self.scrollView!.contentInset = inset
                })
                
               sendActions(for: UIControlEvents.valueChanged)
            }
        }
    }
    
    // endingfunction
    func endRefreshing(){
        
        self.refreshState = .normal
    
    }
    
    //MARK: - 1. define the observer value
    //have to get the tableView for object, recording the tableView for object
    weak var scrollView : UIScrollView?
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        setupUI()
    }
    //MARK: - 2. recall the function to get tableView and add Observer
    //this newSuperview is tableview because when the tableview add refreshview, this func will be recalled. The superview as tableview can be captured
    override func willMove(toSuperview newSuperview: UIView?) {
        
        if newSuperview is UIScrollView{
        
            self.scrollView = newSuperview as? UIScrollView
            
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
        }
    }
    
    //MARK: - 3. monitor the changes of value about tableView contentOffest
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(self.scrollView?.contentOffset)
        //print("monitor scrollView contentOffset")
        
        //MARK: - 3.1 key point to change the state according to the contentOffset
        //capture the value of naviagtion offSet ----- 64
        let contentInsetTop = self.scrollView!.contentInset.top
        let conditionValue: CGFloat = -contentInsetTop - XDLRefreshControlH
        
        if scrollView!.isDragging{
            
            if refreshState == .normal && self.scrollView!.contentOffset.y < conditionValue {
                print("refreshingState")
                refreshState = .pulling
                
            }else if refreshState == .pulling && self.scrollView!.contentOffset.y >= conditionValue {
                print("pullingState")
                refreshState = .normal
            }
            
         }else{
            if refreshState == .pulling{
               refreshState = .refreshing
            }
        }
    }
    
    //MARK: - 4. remove the observer
    deinit {
        
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: --- RefreshControl setupUI()
    private func setupUI(){
        
        backgroundColor = UIColor.black
        frame.size = CGSize(width: XDLScreenW, height: XDLRefreshControlH)
        frame.origin.y = -40
        
        self.addSubview(arrowImage)
        
        self.addSubview(label)
        
        self.addSubview(indicatorView)

        arrowImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        label.snp_makeConstraints { (make) in
            make.leading.equalTo(arrowImage.snp_trailing)
            make.centerY.equalTo(arrowImage)
        }
        
        indicatorView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
    
    }
    
    //MARK: - init UI with pullDown
    
    private lazy var indicatorView :UIActivityIndicatorView = {()-> UIActivityIndicatorView in
        
         let indicatorView = UIActivityIndicatorView()
        
         indicatorView.color = UIColor.gray
    
         return indicatorView
    }()
    
    private lazy var arrowImage :UIImageView = {()-> UIImageView in
        
        let arrowImage = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
        
        return arrowImage
    }()

    
    private lazy var label :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.darkGray, fontSize: 12)
        
        label.text = "loading........."
        
        return label
   
    }()


}
