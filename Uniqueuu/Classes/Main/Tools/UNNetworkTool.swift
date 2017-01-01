//
//  UNNetworkTool.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON

class UNNetworkTool: NSObject {
    /// 单例
    static let shareNetworkTool = UNNetworkTool()
    
    
    /// 获取首页顶部选择数据
    func loadHomeTopData(finished:@escaping (_ ym_channels: [UNChannel]) -> ()) {
        
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response: DataResponse<Any>) in
            
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                if let channels = data!["channels"]?.arrayObject {
                    var ym_channels = [UNChannel]()
                    for channel in channels {
                        let ym_channel = UNChannel(dict: channel as! [String: AnyObject])
                        ym_channels.append(ym_channel)
                    }
                    finished(ym_channels)
                }
            }
        }
    }
    
    /// 获取首页数据
    func loadHomeInfo(id: Int, finished:@escaping (_ homeItems: [UNHomeItem]) -> ()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        
         Alamofire.request(url, method: .get, parameters: params).responseJSON { (response: DataResponse<Any>) in
            
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    let data = dict["data"].dictionary
                    //  字典转成模型
                    if let items = data!["items"]?.arrayObject {
                        var homeItems = [UNHomeItem]()
                        for item in items {
                            let homeItem = UNHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems)
                    }
                }
        }
    }
    /// 分类界面 顶部 专题合集
    
    func loadCategoryCollection(limit: Int, finished:@escaping (_ collections: [YMCollection]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/collections"
        let params = ["limit": limit,
                      "offset": 0]
         Alamofire.request(url, method: .get, parameters: params).responseJSON { (response: DataResponse<Any>) in
            guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let collectionsData = data["collections"]?.arrayObject {
                            var collections = [YMCollection]()
                            for item in collectionsData {
                                let collection = YMCollection(dict: item as! [String: AnyObject])
                                collections.append(collection)
                            }
                            finished(collections)
                        }
                    }
                }
        }
    }

    /// 顶部 专题合集 -> 专题列表
    func loadCollectionPosts(id: Int, finished:@escaping (_ posts: [YMCollectionPost]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/collections/\(id)/posts"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response: DataResponse<Any>) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let postsData = data["posts"]?.arrayObject {
                            var posts = [YMCollectionPost]()
                            for item in postsData {
                                let post = YMCollectionPost(dict: item as! [String: AnyObject])
                                posts.append(post)
                            }
                            finished(posts)
                        }
                    }
                }
        }
    }

    /// 底部 风格品类 -> 列表
    func loadStylesOrCategoryInfo(id: Int, finished:@escaping (_ items: [YMCollectionPost]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["limit": 20,
                      "offset": 0]
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response: DataResponse<Any>) in

            guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let itemsData = data["items"]?.arrayObject {
                            var items = [YMCollectionPost]()
                            for item in itemsData {
                                let post = YMCollectionPost(dict: item as! [String: AnyObject])
                                items.append(post)
                            }
                            finished(items)
                        }
                    }
                }
        }
    }
    /// 分类界面 风格,品类
    func loadCategoryGroup(finished:@escaping (_ outGroups: [AnyObject]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/channel_groups/all"
 
        
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response: DataResponse<Any>) in
               guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let channel_groups = data["channel_groups"]?.arrayObject {
                            // outGroups 存储两个 inGroups 数组，inGroups 存储 YMGroup 对象
                            // outGroups 是一个二维数组
                            var outGroups = [AnyObject]()
                            for channel_group in channel_groups {
                                var inGroups = [YMGroup]()
                                let channels = (channel_group as AnyObject)["channels"]as!NSArray
                             
                                for channel in channels {
                                  
                                    let group = YMGroup(dict: channel as! [String: AnyObject])
                                    inGroups.append(group)
                                }
                                outGroups.append(inGroups as AnyObject)
                            }
                            finished(outGroups)
                        }
                    }
                }
        }
    }

  
}
