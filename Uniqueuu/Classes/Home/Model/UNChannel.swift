//
//  UNChannel.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import Foundation

class UNChannel: NSObject {
    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }
}
