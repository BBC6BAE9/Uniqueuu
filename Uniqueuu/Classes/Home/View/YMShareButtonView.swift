//
//  YMShareButtonView.swift
//  DanTang
//
//  Created by 杨蒙 on 16/7/23.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit

class YMShareButtonView: UIView {
    // 图片数组
    let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
    // 标题数组
    let titles = ["朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        let maxCols = 3
        
        let buttonW: CGFloat = 70
        let buttonH: CGFloat = buttonW + 30
        let buttonStartX: CGFloat = 20
        let xMargin: CGFloat = (SCREENW - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
        // 创建按钮
        for index in 0..<images.count {
            let button = YMVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), for: .normal)
            button.setTitle(titles[index], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.width = buttonW
            button.height = buttonH
            
            button.addTarget(self, action: #selector(shareButtonClick(button:)), for: .touchUpInside)
            
            
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRect(x:buttonX, y:buttonY, width:buttonW, height:buttonH)
            addSubview(button)
        }
    }
    
    @objc func shareButtonClick(button: UIButton) {
        if let shareButtonType = YMShareButtonType(rawValue: button.tag) {
            switch shareButtonType {
            case .WeChatTimeline:shareWebPageToPlatformType(platformType: .wechatTimeLine)
                break
                
            case .WeChatSession: shareWebPageToPlatformType(platformType: .wechatSession)
                break
                
            case .Weibo:
                break
                
            case .QZone:
                break
                
            case .QQFriends:
                break
                
            case .CopyLink:
                break
                
            }
        }
        print(button.titleLabel!.text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shareWebPageToPlatformType(platformType:UMSocialPlatformType) {
        
        
        //创建分享消息对象
        let messageObject: UMSocialMessageObject = UMSocialMessageObject.init()
        //创建网页内容分享
        let thumbURL = "https://mobile.umeng.com/images/pic/home/social/img-1.png"
        
        let shareObject: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "欢迎使用【读物】APP,页面由本世纪最帅程序员huanghong提供",
                                                                                 descr: "本页面由本世纪最帅的程序员BBC6BAE9提供",
                                                                                 thumImage: thumbURL)
        
        //设置网页地址
        shareObject.webpageUrl = "http://www.jianshu.com/p/0778bc56aa47"
        messageObject.shareObject = shareObject
        
        //调用分享接口
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self) { (data, error) in
            
            if (error != nil) {
                print("分享出错了\(error)")
                
            }else{
                print("分享信息\(data)")
                
            }
        }
   }
}
