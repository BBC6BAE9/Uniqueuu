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
        } else {

            window?.rootViewController = UNTabBarController()

        }

        loadLaunchAd()
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

