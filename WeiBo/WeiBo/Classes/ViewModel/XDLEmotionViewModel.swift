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
    
        private lazy var archivePath : String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("recent.archive")

        lazy var emotionBundle :Bundle = {()-> Bundle in
        
        let path = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)!
        let result = Bundle(path:path)!
            
        return result
    }()

        lazy var recentEmotion :[XDLEmotion] = {()-> [XDLEmotion] in
            
        let recentArray = [XDLEmotion]()
        
            if let result = NSKeyedUnarchiver.unarchiveObject(withFile:self.archivePath) as? [XDLEmotion]{
                
                return result
            }
        
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
    
        let pages = (emotion.count - 1) / XDLEmotionKeyBoardPageCount + 1
    
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
    
        //MARK: - saveFunction for recentButton
    
        func savetoRecent(_ emotion:XDLEmotion){
            
//            if self.recentEmotion.contains(emotion){
//                
//                let index = self.recentEmotion.index(of: emotion)
//                self.recentEmotion.remove(at: index!)
//                
//            }
            var index = 0
        
            let isContains = self.recentEmotion.contains(where: { (value) -> Bool in
                
                if value.type == emotion.type{
                    
                    var result = false
                    if value.type == 0{
                        result = value.png == emotion.png
                    }else{
                        result = value.code == emotion.code
                    }
                    
                    if result == true{
                      index = self.recentEmotion.index(of: value)!
                    }
                    return result
                }
                return false
            })
            
            if isContains{
                
                self.recentEmotion.remove(at: index)
            }
            
             self.recentEmotion.insert(emotion, at: 0)
            
             let overCount = self.recentEmotion.count - XDLEmotionKeyBoardPageCount
                
             if overCount > 0{
                
                 self.recentEmotion.removeLast(overCount)
              }
            
            allEmotions[0][0] = self.recentEmotion
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:XDLEmotionReloadNotification), object: nil)
            
            let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("recent.archive")
            
            NSKeyedArchiver.archiveRootObject(self.recentEmotion, toFile: file)
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
