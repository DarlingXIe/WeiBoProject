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
        
       // contentView.addSubview(nameLabel)
        
        OriginalStatusView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
   private lazy var OriginalStatusView : XDLOriginalStatusView = {()-> XDLOriginalStatusView in
        
        let originalView = XDLOriginalStatusView()
        //label.textColor = UIcolor.red
        return originalView
    }()

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
