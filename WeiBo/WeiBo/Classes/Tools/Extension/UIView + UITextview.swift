//
//  UIView + UITextview.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/13.
//  Copyright © 2016年 itcast. All rights reserved.
//
import UIKit

extension UITextView{
    
    func insertEmotion(emotion: XDLEmotion){
    
            if emotion.type == 1{
                self.insertText((emotion.code! as NSString).emoji())
            }else{
                //1. capture the bundle
                let bundle = XDLEmotionViewModel.sharedViewModel.emotionBundle
                let image = UIImage(named: "\(emotion.path!)/\(emotion.png!)", in: bundle, compatibleWith: nil)
                //2. init with TextAttachment for image
                
                let attachment = NSTextAttachment()
                //2.1 get the size of picture
                let imageWH = self.font!.lineHeight
                attachment.bounds = CGRect(x: 0, y: -4, width: imageWH, height: imageWH)
                //2.2
                attachment.image = image
                //3.
                let attr = NSMutableAttributedString(attributedString: self.attributedText)
                //attr.append(NSAttributedString(attachment:attachment))
                //3.1 get mouse loaciton
                var selectedRange = self.selectedRange
                //
                //attr.insert(NSAttributedString(attachment: attachment), at: selectedRange.location)
                attr.replaceCharacters(in: selectedRange, with: NSAttributedString(attachment: attachment))
                //
                attr.addAttribute(NSFontAttributeName, value: self.font!, range: NSMakeRange(0, attr.length))
                
                self.attributedText = attr
                
                selectedRange.location += 1
                //            
                selectedRange.length = 0
                //            
                self.selectedRange = selectedRange
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: self)
        delegate?.textViewDidChange?(self)
     }
    
    var emotionText: String?{
       
        get{
            
            var result = String()
            
            self.attributedText.enumerateAttributes(in: NSMakeRange(0, self.attributedText.length), options: []) { (dict, range, _) in
                print(dict)
                if let attachment = dict["NSAttachment"] as? XDLTextAttachment{
                    
                    print(attachment.chs)
                    result += attachment.chs!
                    
                }else{
                    
                    result += (attributedText.string as NSString).substring(with: range)
                }
            }
            return result
        }
    }
}
