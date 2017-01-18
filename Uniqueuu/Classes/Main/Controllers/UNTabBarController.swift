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
//        addChildViewControllers()
        
        
        setupChildControllers()
        setupComposeButton()
    
    }
    

    private func setupComposeButton(){
        
        tabBar.addSubview(composeButton)
        //设置按钮的位置
        //计算按钮的宽度
        let count:CGFloat = CGFloat(childViewControllers.count)
        let w = tabBar.bounds.width/count
        //缩进
        composeButton.frame = tabBar.bounds.insetBy(dx: 2*w, dy: -15)
        
        
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:-私有控件
    lazy var composeButton:UIButton = UIButton.bb_imageButton("", backgroundImageName: "cus")
    
}


extension UNTabBarController {

     func setupChildControllers(){
        
        //从bundle加载配置的json
        //1.路径
        //2.加载NSData
        //3.反序列化转化成数组
        
        
        //获取沙盒json路径
        
        
        let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        /*因为OC很多东西都改成了结构体，转换成*/
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        
        
        if data == nil {
            
            //从bundle加载data
            
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
            
        }
        
        
        
        guard  let array = try? JSONSerialization.jsonObject(with: data as! Data, options:JSONSerialization.ReadingOptions.allowFragments)as? [[String: Any]]
            else{
                
                return
        }
        
      
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict as! [String : String]))
        }
        viewControllers = arrayM
    }

    private func controller(dict:[String:String])->UIViewController{
        
        //1.取得字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace+"."+clsName)as? UIViewController.Type
            else{
                
                return UIViewController()
                
        }
        
        //2.创建视图控制器
        //系统默认的是12号字
        let vc = cls.init()
        vc.title = title
        let imgName = "\(imageName)"
        vc.tabBarItem.image = UIImage(named: imgName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")

        //设置tabbar的标题字体
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 14)],
                                             for: .highlighted)
        
        
        let nav = UNNavigationController(rootViewController: vc)
        
        return nav
        
    }
    
    
}

