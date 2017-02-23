//
//  UNNewfeatureViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/19.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit
import SnapKit

let newFeatureID = "newFeatureID"

class UNNewfeatureViewController: UICollectionViewController {
    /// 布局对象
    private var layout: UICollectionViewFlowLayout = YMNewfeatureLayout()
    init() {
        super.init(collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(YMNewfeatureCell.self, forCellWithReuseIdentifier: newFeatureID)
        
    }
}

extension UNNewfeatureViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kNewFeatureCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newFeatureID, for: indexPath as IndexPath) as! YMNewfeatureCell
        cell.imageIndex = indexPath.item
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let path = collectionView.indexPathsForVisibleItems.last!
        if path.item == (kNewFeatureCount - 1) {
            let cell = collectionView.cellForItem(at: path) as! YMNewfeatureCell
            cell.startBtnAnimation()
    }
   }
}

/// YMNewfeatureCell
private class YMNewfeatureCell: UICollectionViewCell {
    
     var imageIndex: Int? {
        didSet {
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        }
    }
    
    func startBtnAnimation() {
        startButton.isHidden = false
        // 执行动画
        startButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        startButton.isUserInteractionEnabled = false
        
        // UIViewAnimationOptions(rawValue: 0) == OC knilOptions
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 清空形变
            self.startButton.transform = CGAffineTransform.identity

            }, completion: { (_) -> Void in
                self.startButton.isUserInteractionEnabled = true
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
            make.size.equalTo(CGSize(width:150, height:40))
            make.centerX.equalTo(SCREENW*0.5)
        }
    }
    
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), for: .normal)
        btn.addTarget(self, action: #selector(startButtonClick), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.isHidden = true
        return btn
    }()
    
    @objc func startButtonClick() {
        UIApplication.shared.keyWindow?.rootViewController = UNTabBarController()
    }
}

private class YMNewfeatureLayout: UICollectionViewFlowLayout {
    /// 准备布局
    override func prepare() {
        // 设置 layout 布局
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        // 设置 contentView 属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
    }
}
