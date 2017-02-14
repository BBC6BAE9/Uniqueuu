//
//  AppDelegate.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var launchView: UIView?
    var adwebview: UIWebView?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.5) //延长3秒
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if !UserDefaults.standard.bool(forKey: YMFirstLaunch) {
            window?.rootViewController = UNNewfeatureViewController()
            UserDefaults.standard.set(true, forKey: YMFirstLaunch)
            loadLaunchAd()
        } else {
            
            window?.rootViewController = UNTabBarController()
            
        }
        
        loadAppInfo()
        
        /* 打开调试日志 */
        UMSocialManager.default().openLog(true)
        
        /* 设置友盟appkey */
        UMSocialManager.default().umSocialAppkey = "58a2bd2df5ade459c0001022"
        /*友盟设置*/
        self.confitUShareSettings()
        /*友盟平台设置*/
        self.configUSharePlatforms()
        
        
        return true
    }
    
    func loadLaunchAd(){
        
        var timer = Timer()
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        let storyboard = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        
        let  vc  = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        
        self.launchView = vc.view;
        
        self.adwebview = UIWebView.init(frame: CGRect(x:0, y:0 ,width:SCREENW, height:SCREENW+200))
        self.adwebview?.scalesPageToFit = true
        let url = NSURL(string:"http://img.pcauto.com.cn/images/upload/upc/tx/auto5/1601/10/c2/17413992_1.gif")
        let request = NSURLRequest(url: url! as URL)
        adwebview?.loadRequest(request as URLRequest)
        
        
        self.launchView?.addSubview(adwebview!)
        
        
        self.window?.addSubview(self.launchView!)
        self.window?.bringSubview(toFront: self.launchView!)
        
    }
    
    func timerAction() {
        adwebview?.removeFromSuperview()
        launchView?.removeFromSuperview()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

//下载json数据以实现动态配置页面
extension AppDelegate{
    
    func loadAppInfo(){
        
        // 模拟异步
        DispatchQueue.global().async {
            
            let url = Bundle.main.url(forResource: "mainFromNet.json", withExtension: nil)
            
            let data = NSData(contentsOf: url!)
            
            //写入磁盘
            
            let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            /*因为OC很多东西都改成了结构体，转换成*/
            /*实际开发的时候把这个地方换成网络加载json*/
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕")
            print(jsonPath)
        }
    }
    
}


extension AppDelegate{
    
    func confitUShareSettings() {
        
        
        /*
         * 打开图片水印
         */
        //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
        
        /*
         * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         */
        //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        
        
    }
    
    func configUSharePlatforms(){
        
        /* 设置微信的appKey和appSecret */
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "wx77185c717a77fb02", appSecret: "2e0a96863eada62e35b728f8d672ba6d", redirectURL: "http://mobile.umeng.com/social")
        
        
    }
    
    
}



