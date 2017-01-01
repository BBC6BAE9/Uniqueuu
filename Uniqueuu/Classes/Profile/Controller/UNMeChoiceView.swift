//
//  UNMeChoiceView.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/18.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit
import Kingfisher

class UNMeChoiceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // 左边的按钮
        addSubview(leftButton)
        // 右边的按钮
        addSubview(rightButton)
        // 底部红色条
        addSubview(indicatorView)
        
        leftButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(rightButton)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.left.equalTo(leftButton.snp.right)
            make.top.right.bottom.equalTo(self)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.height.equalTo(kIndicatorViewH)
            make.bottom.left.equalTo(self)
            make.right.equalTo(leftButton)
        }
    }
    
    /// 左边的按钮
    private lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setTitle("喜欢的商品", for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton.setTitleColor(UNColor(r: 0, g: 0, b: 0, a: 0.7), for: .normal)
        leftButton.backgroundColor = UIColor.white
        leftButton.addTarget(self, action: #selector(leftButtonClick(button:)), for: .touchUpInside)
        leftButton.layer.borderColor = UNColor(r: 230, g: 230, b: 230, a: 1.0).cgColor
        leftButton.layer.borderWidth = klineWidth
        leftButton.isSelected = true
        return leftButton
    }()
    
    /// 右边的按钮
    private lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setTitle("喜欢的专题", for: .normal)
        rightButton.setTitleColor(UNColor(r: 0, g: 0, b: 0, a: 0.7), for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightButton.backgroundColor = UIColor.white
        rightButton.addTarget(self, action: #selector(rightButtonClick(button:)), for: .touchUpInside)
        rightButton.layer.borderColor = UNColor(r: 230, g: 230, b: 230, a: 1.0).cgColor
        rightButton.layer.borderWidth = klineWidth
        return rightButton
    }()
    
    /// 底部红色条
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = YMGlobalRedColor()
        return indicatorView
    }()
    
    func leftButtonClick(button: UIButton) {
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: kAnimationDuration) {
            self.indicatorView.x = 0
        }
    }
    
    func rightButtonClick(button: UIButton) {
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: kAnimationDuration) {
            self.indicatorView.x = SCREENW * 0.5
        }
    }
}
