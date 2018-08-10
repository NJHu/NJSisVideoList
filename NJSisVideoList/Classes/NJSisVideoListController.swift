//
//  NJSisVideoListController.swift
//  Pods
//
//  Created by HuXuPeng on 2018/8/10.
//

import UIKit
import NJKit

class NJSisVideoListController: NJRefreshTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nj_isBackActionBtnHidden = true
        self.title = "视频列表"
    }
}
