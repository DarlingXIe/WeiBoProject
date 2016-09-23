//
//  XDLDiscoverSearchView.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

 
import UIKit

@IBDesignable class XDLDiscoverSearchView: UIButton{
    
    
    class func searchView() -> XDLDiscoverSearchView{
        
       // let view = Bundle.main.loadNibNamed("XDLDiscoverSearchView", owner: nil, options: nil)!.last! as! XDLDiscoverSearchView
        
       let view = Bundle.main.loadNibNamed("XDLDiscoverSearchView", owner: nil, options: nil)?.last as! XDLDiscoverSearchView
        
       return view
        
    }
    
    override func awakeFromNib() {
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        
    }

}

