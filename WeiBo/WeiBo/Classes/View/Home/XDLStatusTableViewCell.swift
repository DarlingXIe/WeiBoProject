//
//  XDLStatusTableViewCell.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLStatusTableViewCell: UITableViewCell {

    //before: cell will load data to UItext
  //  var status : XDLStatus?{
    
  //      didSet{
            
 //           nameLabel.text = status?.text
  //      }
 //   }
    
    var XDLStatusViewModel : XDLStatusViewModel?{
        
        didSet{
            
             nameLabel.text = XDLStatusViewModel?.status?.text
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
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp_makeConstraints { (make) in
            
            make.centerY.equalTo(contentView)
            
            make.left.equalTo(contentView).offset(12)
            
            make.right.equalTo(contentView).offset(10)
            
        }
        
    }
    
    
   private lazy var nameLabel :UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.darkGray, fontSize: 14)
    
        label.numberOfLines = 0
    
        label.textAlignment = NSTextAlignment.center
    
        return label
    
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
