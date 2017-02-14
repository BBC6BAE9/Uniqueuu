//
//  UNDetailViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/17.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit
import SVProgressHUD

class UNDetailViewController: UNBaseViewController {
    
    var homeItem: UNHomeItem?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let webView = UIWebView()
        webView.frame = view.bounds
        webView.frame.size.height = view.bounds.height-40
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let url = NSURL(string: homeItem!.content_url!)
        let request = NSURLRequest(url: url! as URL)
        webView.loadRequest(request as URLRequest)
        webView.delegate = self
        view.addSubview(webView)
        
        

        view.addSubview(toolBarView)

       
        
        
    }
    
    //MARK: -懒加载
    /// 底部栏
    private lazy var toolBarView: UIView = {
        
        let toolBarView = Bundle.main.loadNibNamed("UNHomeToolBarView", owner: nil, options: nil)?.last as! UNHomeToolBarView
        
        toolBarView.frame = CGRect(x: 0, y: SCREENH-40, width: SCREENW, height: 40)
        toolBarView.delegate = self
        return toolBarView
    }()

}

extension UNDetailViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.setStatus("正在加载...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    

}

// MARK: - toolBar的代理实现
extension UNDetailViewController: UNToolBarDelegate  {

    
    
    
    func likeBtnClick() {
        
        print("我终于监听到喜欢页面了")
        
    }
    
    func shareBtnClick() {
        
        YMActionSheet.show()
        
    }
    
    func commentBtnClick() {
        
        print("我终于监听到评论了")
        
    }
    
    
    
}
