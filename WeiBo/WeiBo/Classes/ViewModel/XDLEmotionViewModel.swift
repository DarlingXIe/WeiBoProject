//
//  XDLEmotionViewModel.swift
//  WeiBo
//
//  Created by DalinXie on 16/10/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

let XDLEmotionKeyBoardPageCount = 20


class XDLEmotionViewModel: NSObject {
    
        static let sharedViewModel = XDLEmotionViewModel()
    
        lazy var emotionBundle :Bundle = {()-> Bundle in
        
        let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)!
        let result = Bundle(path:path)!
            
        return result
    }()

        lazy var recentEmotion :[XDLEmotion] = {()-> [XDLEmotion] in
            
        let recentArray = [XDLEmotion]()
        
        return recentArray
    }()
    
        //MARK: for each emotion array with model (XDLEmotion)
        lazy var defaultEmotions :[XDLEmotion] = {()-> [XDLEmotion] in
        
        let defaultArray = self.emotions(path: "default/info.plist")
        
        return defaultArray
    }()
    
        lazy var emojiEmotions :[XDLEmotion] = {()-> [XDLEmotion] in
        
        let defaultArray = self.emotions(path: "emoji/info.plist")
        
        return defaultArray
    }()
    
        lazy var LxhEmotions :[XDLEmotion] = {()-> [XDLEmotion] in
        
        let defaultArray = self.emotions(path: "lxh/info.plist")
        
        return defaultArray
    }()
    
        lazy var allEmotions :[[[XDLEmotion]]] = {()-> [[[XDLEmotion]]] in
            
        return [
            [self.recentEmotion],
            self.typeEmotionPages(emotion: self.defaultEmotions),
            self.typeEmotionPages(emotion: self.emojiEmotions),
            self.typeEmotionPages(emotion: self.LxhEmotions)
            ]
    }()

    private func typeEmotionPages(emotion:[XDLEmotion]) -> [[XDLEmotion]]{
    
        let pages = (emotion.count - 1) / 20 + 1
    
        var result = [[XDLEmotion]]()
        
        for i in 0..<pages{
            
            let loc = i * XDLEmotionKeyBoardPageCount
            
            var len = XDLEmotionKeyBoardPageCount
            
            if loc + len > emotion.count{
                
                len = emotion.count - loc
                
            }
            
            let range = NSMakeRange(loc, len)
            
            let subArray = (emotion as NSArray).subarray(with: range) as! [XDLEmotion]
            
            result.append(subArray)
        }
    
        return result
    }
        override init(){
        
        super.init()

    }
        //MARK: define the Funtion for array with dict to array with model
        private func emotions(path: String) -> [XDLEmotion]{
        
        let file = self.emotionBundle.path(forResource: path, ofType: nil)!
        
        let array = NSArray(contentsOfFile: file)!
        
        let emotions = NSArray.yy_modelArray(with: XDLEmotion.self, json: array)! as! [XDLEmotion]
        
            for value in emotions {
                let p = (path as NSString).deletingLastPathComponent
                value.path = p
            }
        return emotions
        
    }


}
