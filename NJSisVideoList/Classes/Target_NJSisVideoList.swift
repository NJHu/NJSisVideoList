//
//  Target_NJSisVideoList.swift
//  NJSisVideoList
//
//  Created by HuXuPeng on 2018/8/10.
//
import UIKit
import NJKit

@objc class Target_NJSisVideoList: NSObject {
    
    @objc func Action_mainViewController(params: [String: AnyObject]) -> UIViewController? {
        
        let childController = NJSisVideoListController(tableViewStyle: .plain)
        let nav = NJNavigationController(rootViewController: childController)
        
        childController.tabBarItem.image = UIImage.nj_image(name: "tabBar_essence_icon", bundleClass: Target_NJSisVideoList.self)
        childController.tabBarItem.selectedImage = UIImage.nj_image(name: "tabBar_essence_click_icon", bundleClass: Target_NJSisVideoList.self)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childController.tabBarItem.title = "视频"
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3);
        
        return nav
    }
}
