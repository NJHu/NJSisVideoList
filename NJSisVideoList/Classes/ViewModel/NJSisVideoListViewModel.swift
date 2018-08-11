//
//  NJSisVideoListViewModel.swift
//  NJSisVideoList
//
//  Created by HuXuPeng on 2018/8/11.
//

import UIKit
import NJKit
import SwiftyJSON

fileprivate let NJSisApi = "http://api.budejie.com/api/api_open.php"

class NJSisVideoListViewModel: NSObject {
    lazy var videoList: [NJSisTopic] = [NJSisTopic]()
    var parameters: [String: Any]?
    var maxtime: String = ""
    
    func getVideos(isMore: Bool, completion: @escaping (_ response: NJResponse?,_ hasMore: Bool) -> ()) -> Void {
        
        var parameter = [String: Any]()
        parameter["a"] = "newlist";
        parameter["c"] = "data";
        parameter["type"] = 41;
        parameter["maxtime"] = isMore ? self.maxtime : nil;
        parameter["per"] = 10;
        
        self.parameters = parameter
        NJNetworkTool.sharedTool.GET(NJSisApi, parameters: parameters) {[weak self] (response: NJResponse) in
            
            guard response.error == nil && response.responseObject != nil && self != nil else {
                completion(response, true)
                return
            }
            
            let jsonData = JSON.init(response.responseObject)
            
            var tempVideoList: [NJSisTopic] = [NJSisTopic]()
            for (index, jsonValue) in jsonData["list"].arrayValue.enumerated() {
                tempVideoList.append(NJSisTopic(jsonData: jsonValue))
            }
            
            if tempVideoList.count > 0 {
                self?.maxtime = jsonData["info"].dictionaryValue["maxtime"]?.stringValue ?? ""
                if !isMore {
                    self?.videoList.removeAll()
                }
                self?.videoList.append(contentsOf: tempVideoList)
            }
            completion(nil, true)
        }
    }
}
