//
//  UNCommunityViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/31.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit



class UNCommunityViewController: UNBaseViewController {
    
    var products = [UNProduct]()
    
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置collectionView
        setupCollectionView()
        
        UNNetworkTool.shareNetworkTool.loadProductData { [weak self] (products) in
            self!.products = products
            self!.collectionView!.reloadData()
        }
    }
    
    /// 设置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String("YMCollectionViewCell"), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UNCommunityViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, YMCollectionViewCellDelegate {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath as IndexPath) as! YMCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = UNProductDetailViewController()
        productDetailVC.title = "商品详情"
        productDetailVC.product = products[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            let loginVC = UNLoginViewController()
            loginVC.title = "登录"
            let nav = UNNavigationController(rootViewController: loginVC)
            present(nav, animated: true, completion: nil)
        } else {
            
        }
    }
}
