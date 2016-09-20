//
//  XDLStatusTableViewCell.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

let XDLStatusCellMargin: CGFloat = 10

class XDLStatusTableViewCell: UITableViewCell {

    //before: cell will load data to UItext
  //  var status : XDLStatus?{
    
  //      didSet{
            
 //           nameLabel.text = status?.text
  //      }
 //   }
    
    var XDLStatusViewModel: XDLStatusViewModel?{
        
        didSet{
            
           OriginalStatusView.statusViewModel = XDLStatusViewModel
           statusToolBar.statusViewModel =  XDLStatusViewModel
           
            if XDLStatusViewModel?.status?.retweeted_status != nil {
                
                retweetView.isHidden = false
                
                retweetView.statusViewModel = XDLStatusViewModel
                
                statusToolBar.snp_remakeConstraints(closure: { (make) in
                
                    make.top.equalTo(retweetView.snp_bottom)
                    make.left.right.bottom.equalTo(contentView)
                    make.height.equalTo(35)
               })
            
            }else{
                
                retweetView.isHidden = true
                
                statusToolBar.snp_remakeConstraints(closure: { (make) in
                    
                    make.top.equalTo(OriginalStatusView.snp_bottom)
                    make.left.right.bottom.equalTo(contentView)
                    make.height.equalTo(35)
               
                })
            }
            
            
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style:UITableViewCellStyle,reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        contentView.addSubview(OriginalStatusView)
        
        contentView.addSubview(statusToolBar)
        
        contentView.addSubview(retweetView)
        
        OriginalStatusView.snp_makeConstraints { (make) in
            
            make.left.top.right.equalTo(contentView)
           // make.bottom.equalTo(contentView)
        }
        
        retweetView.snp_makeConstraints { (make) in
            make.top.equalTo(OriginalStatusView.snp_bottom)
            make.left.right.equalTo(contentView)
        }
    
        statusToolBar.snp_makeConstraints { (make) in
            
            make.top.equalTo(retweetView.snp_bottom)
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(35)
        }

    }
    
    
   private lazy var OriginalStatusView : XDLOriginalStatusView = {()-> XDLOriginalStatusView in
        
        let originalView = XDLOriginalStatusView()
        //label.textColor = UIcolor.red
        return originalView
    }()

   private lazy var statusToolBar :XDLStatusToolBar = {()-> XDLStatusToolBar in
        
        let toolBar = XDLStatusToolBar()
        
        //label.textColor = UIcolor.red
        
        return toolBar
    }()

   private lazy var retweetView :XDLRetweetStatusView = {()-> XDLRetweetStatusView in
        
        let retweetView = XDLRetweetStatusView()
        
        //label.textColor = UIcolor.red
        
        return retweetView
    }()

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
