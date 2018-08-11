//
//  NJSisTopic.swift
//  NJSisVideoList
//
//  Created by HuXuPeng on 2018/8/11.
//

import UIKit
import SwiftyJSON

class NJSisTopic: NSObject {
    var smallPicture: String
    var middlePicture: String
    var largePicture: String
    var videoUrl: String
    var videotime: Double = 0
    var width: Double
    var height: Double
    var text: String
    var id: String
    var cellHeight: Double = 0
    init(jsonData: JSON) {
        smallPicture = jsonData["image0"].stringValue
        middlePicture = jsonData["image2"].stringValue
        largePicture = jsonData["image1"].stringValue
        videoUrl = jsonData["videouri"].stringValue
        width = jsonData["width"].doubleValue
        height = jsonData["height"].doubleValue
        text = jsonData["text"].stringValue
        id = jsonData["id"].stringValue
        cellHeight = 34 + 5 + (height * Double(UIScreen.main.bounds.width) / (width > 0 ? width : 100));
        
        if cellHeight > 280 {
            cellHeight = 280
        }
    }
}
