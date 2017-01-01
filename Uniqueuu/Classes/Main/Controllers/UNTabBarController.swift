//
//  UNTabBarController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

class UNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        /* 添加子控制器*/
        addChildViewControllers()
        
    }

    private func addChildViewControllers() {
        addChildViewController("UNHomeViewController", title: "首页", imageName: "TabBar_home_23x23_")
        addChildViewController("UNCommunityViewController", title: "社区", imageName: "TabBar_gift_23x23_")
        addChildViewController("UNCategoryViewController", title: "定制", imageName: "TabBar_category_23x23_")
        addChildViewController("UNMeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    
    
    private func addChildViewController(_ childViewcontroller: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        print(ns + "." + childViewcontroller)
        let cls: AnyClass? = NSClassFromString(ns + "." + childViewcontroller)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        // 给每个控制器包装一个导航控制器
        let nav = UNNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
