//
//  Bundle+Extensions.swift
//  NameSpace
//
//  Created by huang on 2017/1/13.
//  Copyright © 2017年 BBC6BAE9. All rights reserved.
//

import Foundation

extension Bundle{

    var nameSpace:String {
    
    return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
   
    }

}
