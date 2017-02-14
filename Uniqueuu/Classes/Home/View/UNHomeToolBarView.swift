//
//  UNHomeToolBarView.swift
//  Uniqueuu
//
//  Created by huang on 2017/2/14.
//  Copyright © 2017年 BBC6BAE9. All rights reserved.
//

import UIKit

//协议
protocol UNToolBarDelegate: NSObjectProtocol {
    
    func likeBtnClick()
    func shareBtnClick()
    func commentBtnClick()
    
}

class UNHomeToolBarView: UIView {

    weak var delegate: UNToolBarDelegate?

    /// 点赞
    @IBOutlet weak var likeBtn: UIButton!
    /// 分享
    @IBOutlet weak var shareBtn: UIButton!
    /// 评论
    @IBOutlet weak var commentBtn: UIButton!
    
    
    override func awakeFromNib() {}
   
    @IBAction func shareClick(_ sender: AnyObject) {
    
        delegate?.shareBtnClick()
    
    }
    @IBAction func likeClick(_ sender: AnyObject) {
        
        delegate?.likeBtnClick()
        
    }
    
    @IBAction func commentClick(_ sender: AnyObject) {
        
        delegate?.commentBtnClick()
        
    }
}
