//
//  XDLTextView.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

class XDLTextView: UITextView {
    
    var placeholder: String?{
        
        didSet{
            placeholderLabel.text = placeholder
        }
    }
    
    override var font: UIFont?{

        didSet{
            placeholderLabel.font = font
        }
        
    }
    override init(frame: CGRect, textContainer: NSTextContainer?){
        
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    //MARK: - addNotficationforTextView
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
    }
    @objc private func textDidChange(){
        
        placeholderLabel.isHidden = hasText
        
    }
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.snp_updateConstraints { (make) in
            make.width.lessThanOrEqualTo(self.frame.width - 2 * 5)
        }
    }
    //MARK: - setupUI
    private func setupUI(){
        addSubview(placeholderLabel)
        
        placeholderLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(8)
            make.top.equalTo(self).offset(8)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
        
    private lazy var placeholderLabel: UILabel = {()-> UILabel in
        
        let label = UILabel(textColor: UIColor.lightGray, fontSize: 12)
        
        label.numberOfLines = 0
        
        return label
    }()

    
    
}
