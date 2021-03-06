//
//  XDLCommonTools.swift
//  WeiBo
//
//  Created by DalinXie on 16/9/17.
//  Copyright © 2016年 itcast. All rights reserved.
//
import UIKit

let XDLChangeRootController = "XDLChangeRootController"

// click the EmotionButtonSelected   Notification 
let XDLEmoticonButtonDidSelectedNotification = "XDLEmoticonButtonDidSelectedNotification"
// click theEmotionButton for saving into recentButtons to reload
let XDLEmotionReloadNotification = "HMEmoticonReloadNotification"

let XDLScreenW = UIScreen.main.bounds.width
let XDLScreenH = UIScreen.main.bounds.height

var SQScanCodeWH = 300

var RandomColor: UIColor {
        get {
    return UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
        }
}

